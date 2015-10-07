require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "returns http success" do
      post :create, user: attributes_for(:user)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    context "user is valid" do
      it "returns 200 success status code" do
        @daisi = create(:user)
        request.headers['AUTHORIZATION'] ="Token token=#{@daisi.auth_token}"
        get :show, id: @daisi
        expect(response).to have_http_status(:success)
      end
    end

    context "user is invalid"  do
      it "returns 200" do
        @daisi = create(:user)
        @other_user = create(:second_user)
        request.headers['AUTHORIZATION'] ="Token token=#{@daisi.auth_token}"
        get :show, id: @other_user
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "PUT #update" do
    it "updates valid user" do
      @daisi = create(:user)
      request.headers['AUTHORIZATION'] ="Token token=#{@daisi.auth_token}"
      put :update, id: @daisi, user: attributes_for(:update_user)
      expect(response).to have_http_status(:success)
    end

    it "does not update valid user" do
      @daisi = create(:user)
      @other_user = create(:second_user)
      request.headers['AUTHORIZATION'] ="Token token=#{@daisi.auth_token}"
      put :update, id: @other_user, user: attributes_for(:update_user)
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE #destroy" do
    it "destroys valid user if authorized" do
      @daisi = create(:user)
      request.headers['AUTHORIZATION'] ="Token token=#{@daisi.auth_token}"
      delete :destroy, id: @daisi
      expect(response).to have_http_status(:success)
    end

    it "does not destroy user if not authorized" do
      @daisi = create(:user)
      @other_user = create(:second_user)
      request.headers['AUTHORIZATION'] ="Token token=#{@daisi.auth_token}"
      delete :destroy, id: @other_user
      expect(response).to have_http_status(:success)
    end
  end

end
