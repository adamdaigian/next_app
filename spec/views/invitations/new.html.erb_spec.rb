require 'spec_helper'

describe "invitations/new.html.erb" do

  it "displays invitation form" do
    visit apply_path
    expect(find("input[placeholder='Name']")).to_not be_blank
    expect(find("input[placeholder='Email']")).to_not be_blank
    expect(find("input[value='Request Invitation']")).to_not be_blank
  end
end