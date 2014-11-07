class Authentication < ActiveRecord::Base

  include Rails.application.routes.url_helpers
  include ApplicationHelper

  has_one :invitation
  belongs_to :account



  def self.create_authentication_and_object(omniauth, origin)
    authentication = Authentication.find_or_new_authentication_from_hash(omniauth)
    authentication.save
    
    object = authentication.find_or_build_object(origin, omniauth)

    authentication.save # this will also save the associated object, and update foreign keys
    authentication
  end


  def self.find_or_new_authentication_from_hash(omniauth)
    authentication = Authentication.find_or_initialize_by(provider: omniauth['provider'], uid: omniauth['uid'])

    authentication.oauth_token = omniauth['credentials']['token']
    authentication.oauth_secret = omniauth['credentials']['secret']
    #authentication.refresh_token = omniauth['credentials'].refresh_token
    authentication.expires_at = omniauth['credentials']['expires_at'] # this is timestamp format
    authentication.properties = omniauth.to_json
    authentication
  end


  def action(origin)
    case origin
    when /signup/
      # create account and redirect to processing
      "create_account"
    else # it's from the home page, it's for invitations
      "create_invitation"
    end
    
  end


  def calculate_action_and_path(origin)
    if self.account.present?
      action = "redirect_to"
      # path  = "/hi/processing/#{self.account.token}"
      path  = eb_path(processing_path(self.account))

    elsif self.invitation.present?
      action = "redirect_to"
      #path  =  "/shhh/welcome/#{self.invitation.token}"
      path  =  eb_path(welcome_path(self.invitation))

    else
      action = "render"

      case self.action(origin)
      when "create_account"
        path = eb_path("/signup")

      when "create_invitation"
        path = eb_path("/apply")

      end
    end
    [action, path]
  end


  def find_or_build_object(origin, omniauth)
    case self.action(origin)
    when "create_account"
      Account.find_by_email(self.github_email) || self.new_account_from_hash
    when "create_invitation"
      Invitation.find_by_email(self.github_email) || self.new_invitation_from_hash
    end
  end


  def github_image
    omniauth = JSON(self.properties)
    image = omniauth['info']['image']
    image
  end

  def github_name
    omniauth = JSON(self.properties)
    name = omniauth['info']['name']
    name
  end

  def github_username
    omniauth = JSON(self.properties)
    nickname = omniauth['info']['nickname']
    nickname
  end


  def github_uid
    omniauth = JSON(self.properties)
    uid = omniauth['uid'].to_i
    uid
  end


  def github_email
    omniauth = JSON(self.properties)
    email = omniauth['info']['email']
    email
  end


  def new_invitation_from_hash
    name = self.github_name
    nickname = self.github_username
    email = self.github_email

    invite_name = name.blank? ? nickname : name

  	self.build_invitation(name: invite_name, email: email, authentication_id: self.id)
  end



  def new_account_from_hash
    name = self.github_name
    nickname = self.github_username
    email = self.github_email

    account_name = name.blank? ? nickname : name

    self.build_account(name: account_name, email: email, does_not_require_password: true)
  end


end
