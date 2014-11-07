require 'spec_helper'

describe 'Managing invitation', type: 'feature' do
  include BasicAuthHelper

  it "protects page with user / password" do
    visit invitations_path
    expect(page).to_not have_content "Invitations"
  end

  it "can access invitation list with user/pwd" do
    http_login
    visit invitations_path
    expect(page).to have_content "Invitations"
  end

  pending "can validate an invitation"
end