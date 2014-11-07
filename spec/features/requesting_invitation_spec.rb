require 'spec_helper'

describe 'Requesting invitation', type: 'feature' do
  it "can request an invitation" do
    visit apply_path
    fill_in 'Name', with: 'Mario Bross'
    fill_in 'Email', with: 'mario@bross.com'
    click_button 'Request'
    expect(Invitation.last.email).to eq 'mario@bross.com'
    expect(current_path).to eq "/welcome/#{Invitation.last.token}"
    expect(page).to have_content Invitation.last.token
  end

  it "displays error messages if invitation is not valid" do
    visit apply_path
    fill_in 'Name', with: 'Mario Bross'
    fill_in 'Email', with: 'mario@bross'
    click_button 'Request'
    expect(page).to have_content('is not a valid email')
  end

  it "redirects to welcome page if user is already on the waiting list" do
    invitation = FactoryGirl.create(:invitation)
    visit apply_path
    fill_in 'Email', with: invitation.email
    click_button 'Request'
    expect(current_path).to eq "/welcome/#{invitation.token}"
  end
end