require 'spec_helper'

describe InvitationsController, :type => :controller do
  include BasicAuthHelper

  describe "GET 'index'" do
    it "returns http success with correct username / password" do
      http_login_controller
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'index'" do
    it "returns http failure with incorrect username / password" do
      @request.env["HTTP_AUTHORIZATION"] = "Basic " + Base64::encode64("#{APP_CONFIG['admin_username']}:")
      get 'index'
      response.should_not be_success

      @request.env["HTTP_AUTHORIZATION"] = "Basic " + Base64::encode64(":APP_CONFIG['admin_pwd']")
      get 'index'
      response.should_not be_success

      @request.env["HTTP_AUTHORIZATION"] = "Basic " + Base64::encode64(":")
      get 'index'
      response.should_not be_success

      @request.env["HTTP_AUTHORIZATION"] = "Basic " + Base64::encode64("fakeuser:fakepwd")
      get 'index'
      response.should_not be_success
    end
  end

#  describe "GET 'new'" do
#    pending "returns http success" do
#      get 'new'
#      response.should be_success
#    end
#  end
#
#  describe "GET 'create'" do
#    pending "returns http success" do
#      post 'create'
#      response.should be_success
#    end
#  end
#
#  describe "GET 'destroy'" do
#    pending "returns http success" do
#      destroy 'destroy'
#      response.should be_success
#    end
#  end
#
#  describe "GET 'edit'" do
#    pending "returns http success" do
#      get 'edit'
#      response.should be_success
#    end
#  end
#
#  pending "GET 'validate'" do
#    it "returns http success" do
#      get 'validate'
#      response.should be_success
#    end
#  end

end
