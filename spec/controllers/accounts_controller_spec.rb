require 'spec_helper'

describe AccountsController, type: :controller do

	describe "GET 'login'" do
		it "returns http success" do
			get 'login'
			response.should be_success
		end
	end

	describe "GET 'signup'" do
		it "returns http success" do
			get 'signup'
			response.should be_success
		end
	end
	

end
