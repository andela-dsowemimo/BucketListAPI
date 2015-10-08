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
        User.destroy_all
        @daisi = create(:user)
        request.headers['AUTHORIZATION'] ="Token token=#{@daisi.auth_token}"
      end

      after :each do
        expect(response).to have_http_status(:success)
      end

      it "is valid" do
        expect { post :create, bucketlist: attributes_for(:unowned_bucketlist), email: @daisi.email
        }.to change(Bucketlist, :count).by(1)
        expect(JSON.parse(response.body)["name"]).to eq("Things to do before I graduate")
        expect(JSON.parse(response.body)["items"]).to eq([])
      end

      it "is invalid" do
        @other_user = create(:user, email: "other@yahoo.com", auth_token: "Mjsafwefbewoq32")
        expect { post :create, bucketlist: attributes_for(:unowned_bucketlist),email: @other_user.email
        }.not_to change(Bucketlist, :count)
        expect(response.body).to eq("You don't have access to create bucketlists for other users")
      end
    end
  end

  describe "GET #show" do
    context "Users access" do
      before :each do
        @daisi = create(:user)
        @bucketlist = create(:bucketlist)
        request.headers['AUTHORIZATION'] ="Token token=#{@daisi.auth_token}"
      end

      after :each do
        expect(response).to have_http_status(:success)
      end

      it "is valid" do
        @bucketlist.user = @daisi
        @bucketlist.save
        get :show, id: @bucketlist
        expect(JSON.parse(response.body)["name"]).to eq("Things to get done before I turn 30")
        expect(JSON.parse(response.body)["items"]).to eq([])
      end

      it "is invalid" do
        get :show, id: @bucketlist
        expect(response.body).to eq("You cannot view this bucketlist")
      end
    end
  end

  describe "PUT #update" do
    before :each do
      @daisi = create(:user)
      @bucketlist = create(:bucketlist)
      request.headers['AUTHORIZATION'] ="Token token=#{@daisi.auth_token}"
    end

    after :each do
      expect(response).to have_http_status(:success)
    end

    it "is updated if user is authorized" do
      @bucketlist.user = @daisi
      @bucketlist.save
      put :update, id: @bucketlist, bucketlist: attributes_for(:bucketlist_one), user: @daisi
      expect(JSON.parse(response.body)["name"]).to eq("Things to do before the year ends")
      expect(JSON.parse(response.body)["items"]).to eq([])
    end

    it "is not updated if user is not authorized" do
      put :update, id: @bucketlist, bucketlist: attributes_for(:bucketlist)
      expect(response.body).to eq("You cannot update this bucketlist")
    end
  end

  describe "DELETE #destroy" do
    before :each do
      @daisi = create(:user)
      @bucketlist = create(:bucketlist)
      request.headers['AUTHORIZATION'] ="Token token=#{@daisi.auth_token}"
    end

    after :each do
      expect(response).to have_http_status(:success)
    end

    it "is deleted if user is authorized" do
      @bucketlist.user = @daisi
      @bucketlist.save
      expect{delete :destroy, id: @bucketlist}.to change(Bucketlist, :count).by(-1)
      expect(response.body).to eq("You have Successfully Deleted the Bucketlist")
    end

    it "is not deleted if user is not authorized" do
      delete :destroy, id: @bucketlist
      expect(response.body).to eq("You do not have the right to delete this bucketlist")
    end
  end
end
