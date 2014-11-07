require 'spec_helper'

describe 'Accessing root', type: 'feature' do
  it "displays homepage" do
    visit root_path
    expect(page).to have_content('Deploy apps in one click. Any stack. Any host.')
  end

  it "request an invite with Github" do
  	visit root_path
  	click_link "Request with Github"
  	expect(Authentication.last.uid).to eq '12345'
  	expect(Invitation.last.email).to eq 'iam@github.user'
  	expect(page).to have_content "You're in"
  end

  it "request an invite with Email" do
  	invitation = FactoryGirl.build(:invitation)
  	visit root_path
  	find(:css, 'a#email-signup').click
  	fill_in 'invitation_name', with: invitation.name
  	fill_in 'invitation_email', with: invitation.email
  	click_button 'Request Invitation'
  	expect(Invitation.last.email).to eq invitation.email
  	expect(page).to have_content "You're in"
  end


  it "redirects to welcome page if request TWICE with Github" do
    visit root_path
    click_link "Request with Github"
    expect(Authentication.last.uid).to eq '12345'
    expect(Invitation.last.email).to eq 'iam@github.user'
    expect(page).to have_content "You're in"

    visit root_path
    click_link "Request with Github"
    expect(page).to have_content "You're in"
  end

end