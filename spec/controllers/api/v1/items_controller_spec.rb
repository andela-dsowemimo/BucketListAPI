require 'rails_helper'

RSpec.describe Api::V1::ItemsController, type: :controller do
  describe "GET #new" do
    it "returns http success" do
      @bucketlist = create(:bucketlist)
      get :new, bucketlist_id: @bucketlist
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "creates item if user is rightful owner of bucketlist" do
      @daisi = create(:user)
      request.headers['AUTHORIZATION'] ="Token token=#{@daisi.auth_token}"
      @bucketlist = create(:bucketlist)
      @bucketlist.user = @daisi
      @bucketlist.save
      post :create, bucketlist_id: @bucketlist, item: attributes_for(:item)
      expect(response).to have_http_status(:success)
    end

    it "does not create item if user is not rightful owner of bucketlist" do
      @daisi = create(:user)
      request.headers['AUTHORIZATION'] ="Token token=#{@daisi.auth_token}"
      @bucketlist = create(:bucketlist)
      post :create, bucketlist_id: @bucketlist, item: attributes_for(:item)
      expect(response).to have_http_status(:success)
    end
  end

  describe "PUT #update" do
    it "updates item if user is rightful owner of bucketlist" do
      @daisi = create(:user)
      request.headers['AUTHORIZATION'] ="Token token=#{@daisi.auth_token}"
      @bucketlist = create(:bucketlist)
      @bucketlist.user = @daisi
      @bucketlist.save
      @item = create(:item)
      put :update, bucketlist_id: @bucketlist, id: @item, item: attributes_for(:item_two)
      expect(response).to have_http_status(:success)
    end

    it "does not update item if user is not rightful owner of bucketlist" do
      @daisi = create(:user)
      request.headers['AUTHORIZATION'] ="Token token=#{@daisi.auth_token}"
      @bucketlist = create(:bucketlist)
      @item = create(:item)
      put :update, bucketlist_id: @bucketlist, id: @item, item: attributes_for(:item_two)
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE #destroy" do
    it "deletes item if user is rightful owner" do
      @daisi = create(:user)
      request.headers['AUTHORIZATION'] ="Token token=#{@daisi.auth_token}"
      @bucketlist = create(:bucketlist)
      @bucketlist.user = @daisi
      @item = create(:item)
      @bucketlist.items << @item
      @bucketlist.save
      delete :destroy, bucketlist_id: @bucketlist, id: @item
      expect(response).to have_http_status(:success)
    end

    it "delete item if user is not rightful owner" do
      @daisi = create(:user)
      request.headers['AUTHORIZATION'] ="Token token=#{@daisi.auth_token}"
      @bucketlist = create(:bucketlist)
      @item = create(:item)
      delete :destroy, bucketlist_id: @bucketlist, id: @item
      expect(response).to have_http_status(:success)
    end
  end

end
