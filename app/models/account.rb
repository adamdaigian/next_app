# http://girders.org/blog/2011/10/30/how-queuing-with-resque-works/

class Account < ActiveRecord::Base
	require 'digest/sha1'

	include EBAPI

	has_one :authentication,
				dependent: :destroy


	validate :has_valid_email?

	validates :email,
				presence: true,
				uniqueness: true

	validates :eb_tenant_name,
				uniqueness: true,
				unless: Proc.new { |a| a.eb_tenant_name.blank? }

	# password is required, unless the account is created via authentication.
	# (in which case we pass does_not_require_password = true)
#	validates :password,
#				presence: true,
#				unless: :does_not_require_password
#
	validates :name,
				presence: true

	before_save :set_email_and_encrypt_password
	before_create :generate_token#_and_calculate_name
	after_create :enqueue_tenant_creation


	attr_accessor :password, :does_not_require_password


	def to_param
		self.token
	end


	def create_tenant(options={})
		self.calculate_tenant_name!
		self.password = options.try(:[], "password")

		payload = self.eb_json

		response = EBAPI::create_tenant(payload)

	    case response
	    when Net::HTTPSuccess
	    	begin
		    	self.eb_cookie = JSON(response.body)["cookie"]
		    	self.eb_tenant_id = JSON(response.body)["id"]
		    	self.does_not_require_password = true
		    	self.save

		    rescue ActiveRecord::RecordNotSaved => e
		    	logger.error self.errors.full_messages

		    	self.error_creating_tenant!
		    	false
		    end
	    else
	    	#how do we communicate an error?
	    	self.error_creating_tenant!
	    	false
	    end
	end



	def check_tenant_status

		logger.debug ">>>>>>> CHECK TENANT STATUS >>>> #{self.eb_tenant_id.blank?}"

		case self.eb_tenant_id
		when blank? || nil
			'processing'

		when "error"
			"error"

		else
			response = EBAPI::tenant_status(self.eb_tenant_id)

		    case response
		    when Net::HTTPSuccess
		    	#tenant is started, need to check status for ready
		    	logger.debug "SUCCESS!"
		    	logger.debug response.body.inspect

		    	status = JSON(response.body)['status']
		    	status
		    else
		    	#how do we communicate an error?
		    	logger.debug "ERROR :'("
		    	logger.debug response.body.inspect

		    	false
		    end
		end

	end



	def destroy_tenant
		logger.debug ">>>>>>> CHECK TENANT STATUS >>>> #{self.eb_tenant_id}"

    	response = EBAPI::destroy_tenant(self.eb_tenant_id)

	    case response
	    when Net::HTTPSuccess
	    	self.eb_tenant_id = ""
	    	self.eb_tenant_name = ""
	    	self.does_not_require_password = true
	    	self.save!
	    end
	end



	def eb_json
    	user_json = {
    		"name"  => self.eb_tenant_name, 
    		"owner" => {
    			"password" => self.password || "", # password is only passed at signup via email
    			"first_name" => self.first_name,
    			"last_name" => self.last_name,
    			"email" => self.email
    		}
    	}

    	if self.authentication
    		github_json = {
    			"username" => self.authentication.try(:github_username),
    			"id" => self.authentication.try(:github_uid)
    		}

    		icon_json = self.authentication.try(:github_image)

    		user_json["owner"]["github"] = github_json
    		user_json["owner"]["icon"] = icon_json if icon_json
    	end

    	user_json.to_json
	end

	def error_creating_tenant!
		self.eb_tenant_id = "error"
		self.does_not_require_password = true
		self.save!
	end

	def calculate_tenant_name!
		self.calculate_tenant_name
		self.does_not_require_password = true
		self.save!		
	end

	def calculate_tenant_name
		tenant_name = self.authentication.try(:github_username).try(:only_letters_and_numbers) || self.email.email_root.only_letters_and_numbers
		cnt = 0

		while Account.find_by_eb_tenant_name(tenant_name+cnt.to_s) do
			cnt += 1
			tenant_name = tenant_name + cnt.to_s
		end if Account.find_by_eb_tenant_name(tenant_name)

		self.eb_tenant_name = tenant_name
		self
	end





	protected
	def downcase_email
		self.email = self.email.downcase
	end


	def encrypt_password
		if self.password.present?
			self.encrypted_password = Digest::SHA1.hexdigest(self.password)
		end		
	end

	def first_name
		self.name.split(' ')[0]
	end

	def last_name
		self.name.split(' ')[1] || ""
	end



	private
	def has_valid_email?
		unless !self.email.blank? and self.email.is_valid_email?
			errors.add :email, "is not valid"
		end
	end


	def generate_token#_and_calculate_name
		self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
		#self.name = self.authentication.try(:github_username) if self.name.blank?
	end


	def enqueue_tenant_creation
		options = {}
		options[:password] = self.try(:password)

		Resque.enqueue(CreateEBAccount, self.id, options)
	end


	def set_email_and_encrypt_password
		self.encrypt_password
		self.downcase_email
	end
end