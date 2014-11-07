class Invitation < ActiveRecord::Base
	belongs_to :authentication


	validate :has_valid_email?
	validate :not_on_waiting_list

#	validates :name,
#				presence: true

	before_save :downcase_email
	before_create :generate_token
	after_create :send_email


	def validate!
		self.validated_at = Time.now
		self.save
	end


	def validated?
		!self.validated_at.blank?
	end

	def to_param
		self.token
	end


	private
	def has_valid_email?
		unless !self.email.blank? and self.email.is_valid_email?
			errors.add :email, "is not a valid email"
		end
	end


	def not_on_waiting_list
		inv = Invitation.find_by_email(email)
		if inv
			errors.add :email, 'is already on the waiting list'
		end
	end


	def generate_token
		self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
	end


	def downcase_email
		self.email = self.email.downcase
	end


	def send_email
      InvitationMailer.welcome_email(self.id).deliver
	end

end
