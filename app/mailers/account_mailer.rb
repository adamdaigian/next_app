class AccountMailer < ActionMailer::Base
include Resque::Mailer

  default from: APP_CONFIG['mail_user']

  def welcome_email(account_id)
    @account = Account.find(account_id)
    @url  = 'http://example.com/login'
    mail(to: @account.email, subject: 'Welcome to the ElasticBox Developer Edition')
  end
end
