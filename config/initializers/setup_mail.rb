# production.rb, test.rb, development.rb or application.rb
require 'mail_interceptor'

EbV3::Application.configure do
  config.action_mailer.smtp_settings = {
    address:                "smtp.mandrillapp.com",
    port:                   25,                           # ports 587 and 2525 are also supported with STARTTLS
    domain:                 APP_CONFIG['host'],           # your domain to identify your server when connecting
    user_name:              APP_CONFIG['mandrill_email'],
    password:               APP_CONFIG['mandrill_key'],   # SMTP password is any valid API key
    authentication:         :plain,                       # Mandrill supports 'plain' or 'login'
    enable_starttls_auto:   true                          # detects and uses STARTTLS
  }

end

ActionMailer::Base.default_url_options[:host] = APP_CONFIG['host']
ActionMailer::Base.register_interceptor(MailInterceptor) if Rails.env.development? or Rails.env.test?