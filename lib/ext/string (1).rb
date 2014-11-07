class String

  def is_valid_email?
    !/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i.match(self).nil?
  end

  def email_root
  	self.split('@')[0]
  end

  def only_letters_and_numbers
  	self.gsub(/[^0-9a-z]/i, '')
  end

end