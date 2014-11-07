require "spec_helper"

describe InvitationMailer do
	it "sends invitation email" do
		invitation = FactoryGirl.create(:invitation)
		email = InvitationMailer.welcome_email(invitation).deliver
		expect(ActionMailer::Base.deliveries).to_not be_empty

		expect(email.from).to eq [APP_CONFIG['mandrill_email']]

		# the email is intercepted with EmailInterceptor, 
		# so testing that the recipient was included as part of the subject line
		expect(email.subject).to include(invitation.email)
		expect(email.subject).to include("You are on the waiting list")
	end
end
