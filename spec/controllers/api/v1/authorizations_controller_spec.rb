require 'rails_helper'

RSpec.describe Api::V1::AuthorizationsController, type: :controller do
  describe "POST #create" do
    it "should not sign in an invalid user" do
      post :create, user: :invalid_user, password: "sdfsa;dn"
      expect(response).to have_http_status(:success)
      expect(response.body).to eq("Invalid Email or Password")
    end

    it "should sign in a valid user" do
      @user = create(:user)
      post :create, email: @user.email, password: @user.password
      json_response = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(json_response["name"]).to eq(@user.name)
      expect(json_response["email"]).to eq(@user.email)
    end
  end

  describe "DELETE #destroy" do
    it "should log out a user" do
      @user = create(:user)
      request.headers['AUTHORIZATION'] ="Token token=#{@user.auth_token}"
      delete :destroy
      expect(response).to have_http_status(:success)
      expect(response.body).to eq("You have Successfully Logged Out")
    end
  end
end
