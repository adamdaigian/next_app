class InvitationMailer < ActionMailer::Base
include Resque::Mailer

  default from: APP_CONFIG['mail_user']

  def welcome_email(invitation_id)
    @invitation = Invitation.find(invitation_id)
    @url  = 'http://example.com/login'
    mail(to: @invitation.email, subject: 'You are on the waiting list')
  end
end
