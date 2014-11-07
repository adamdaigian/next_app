require 'spec_helper'

describe 'Signing up', type: 'feature' do
  before do
    ResqueSpec.reset!
  end

  it "can signup" do
    visit signup_path
    fill_in 'Name', with: 'Mario Bross'
    fill_in 'Email', with: 'Mario@Bross.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign up'

    expect(page).to have_content "Please wait while your account is being created!"
    expect(CreateEBAccount).to have_queue_size_of(1)
    expect(Account.last.encrypted_password).not_to be_empty
  end


  it "can not signup with invalid email" do
    visit signup_path
    fill_in 'Name', with: 'Mario Bross'
    fill_in 'Email', with: 'Mario'
    fill_in 'Password', with: 'password'
    click_button 'Sign up'

    expect(page).to have_content('Email is not valid')
    expect(CreateEBAccount).to have_queue_size_of(0)
  end


  it "signs up with Github" do
    visit signup_path
    click_link "Sign up with Github"
    expect(Authentication.last.uid).to eq '12345'
    expect(Account.last.email).to eq 'iam@github.user'
    expect(Authentication.last.account_id).to eq Account.last.id
    expect(page).to have_content "Please wait while your account is being created!"
  end


end