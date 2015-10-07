require 'rails_helper'

RSpec.describe Api::V1::BucketlistsController, type: :controller do

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
    context "Users access" do
      before :each do
        @daisi = create(:user)
      end

      it "is valid" do
        request.headers['AUTHORIZATION'] ="Token token=#{@daisi.auth_token}"
        post :create, bucketlist: attributes_for(:unowned_bucketlist), email: @daisi.email
        expect(response).to have_http_status(:success)
      end

      it "is invalid" do
        @other_user = create(:user, email: "other@yahoo.com", auth_token: "Mjsafwefbewoq32")
        request.headers['AUTHORIZATION'] ="Token token=#{@daisi.auth_token}"
        post :create, bucketlist: attributes_for(:unowned_bucketlist), email: @other_user.email
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "GET #show" do
    context "Users access" do
      it "is invalid" do
        @daisi = create(:user)
        @bucketlist = create(:bucketlist)
        @bucketlist.user = @daisi
        @bucketlist.save
        request.headers['AUTHORIZATION'] ="Token token=#{@daisi.auth_token}"
        get :show, id: @bucketlist
        expect(response).to have_http_status(:success)
      end

      it "is invalid" do
        @daisi = create(:user)
        @bucketlist = create(:bucketlist)
        request.headers['AUTHORIZATION'] ="Token token=#{@daisi.auth_token}"
        get :show, id: @bucketlist
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "PUT #update" do
    it "is updated if user is authorized" do
      @daisi = create(:user)
      @bucketlist = create(:bucketlist)
      @bucketlist.user = @daisi
      @bucketlist.save
      request.headers['AUTHORIZATION'] ="Token token=#{@daisi.auth_token}"
      put :update, id: @bucketlist, bucketlist: attributes_for(:bucketlist_one), user: @daisi
      expect(response).to have_http_status(:success)
    end

    it "is not updated if user is not authorized" do
      @daisi = create(:user)
      @bucketlist = create(:bucketlist)
      request.headers['AUTHORIZATION'] ="Token token=#{@daisi.auth_token}"
      put :update, id: @bucketlist, bucketlist: attributes_for(:bucketlist)
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE #destroy" do
    it "is deleted if user is authorized" do
      @daisi = create(:user)
      @bucketlist = create(:bucketlist)
      @bucketlist.user = @daisi
      @bucketlist.save
      request.headers['AUTHORIZATION'] ="Token token=#{@daisi.auth_token}"
      delete :destroy, id: @bucketlist
      expect(response).to have_http_status(:success)
    end

    it "is not deleted if user is not authorized" do
      @daisi = create(:user)
      @bucketlist = create(:bucketlist)
      request.headers['AUTHORIZATION'] ="Token token=#{@daisi.auth_token}"
      delete :destroy, id: @bucketlist
      expect(response).to have_http_status(:success)
    end
  end
end
