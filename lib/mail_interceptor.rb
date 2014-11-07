class MailInterceptor
  def self.delivering_email(message)
  	Rails.logger.debug "* INTERCEPTING EMAIL >>> #{message.subject}"
    message.subject = "#{message.to} :: #{message.subject}"
    message.to = APP_CONFIG['mail_user']
  end
end