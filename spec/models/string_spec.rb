require 'spec_helper'

describe String do
    it "should return false for not formatted email address" do
      email = "not@valid_email"
      email.is_valid_email?.should eq false
    end

    it "should return true for correctly formatted email addresses" do
      email = "a_valid@email.com"
      email.is_valid_email?.should eq true
    end
end