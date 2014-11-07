require 'spec_helper'

describe Invitation do
  let(:i) { FactoryGirl.build(:invitation) }

  describe "should be valid" do

    it "if it has valid email and name" do
      expect(i).to be_valid      
    end

    it "unless email is blank" do
      i.email = nil
      expect(i).not_to be_valid

      i.email = ""
      expect(i).not_to be_valid
    end

    it "unless name is blank" do
      i.name = nil
      expect(i).not_to be_valid

      i.name = ""
      expect(i).not_to be_valid
    end


    it "unless email is invalid" do
      i.email = "alex@test"
      expect(i).not_to be_valid
    end


    it "unless email is already on waitlist" do
      i.save
      new_invite = Invitation.new(email: i.email, name: "Luigi Bross")
      expect(new_invite).not_to be_valid
    end

  end



  describe "should apply callback" do
    it "for email formatting" do
      i.email = "Alex@GmAIl.com"
      i.save
      expect(i.email).to eq "alex@gmail.com"
    end

    it "for token generation" do
      i = FactoryGirl.create(:invitation, email: "luigi@bross.com")
      expect(i.token).not_to be_empty
    end
  end


  describe "should accept validation" do
    it "is validated" do
      i.validate!
      expect(i.validated_at).not_to be_blank
      expect(i.validated?).to eq true
    end
  end


end
