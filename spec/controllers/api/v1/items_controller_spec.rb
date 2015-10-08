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
      expect{post :create, bucketlist_id: @bucketlist,
        item: attributes_for(:item)
      }.to change(Item, :count).by(1)
      expect(JSON.parse(response.body)["name"]).to eq("Things to do before I turn 30")
      expect(JSON.parse(response.body)["items"][0]["name"]).to eq("Get Married")
      expect(JSON.parse(response.body)["items"][0]["done"]).to eq(false)
      expect(response).to have_http_status(:success)
    end

    it "does not create item if user is not rightful owner of bucketlist" do
      @daisi = create(:user)
      request.headers['AUTHORIZATION'] ="Token token=#{@daisi.auth_token}"
      @bucketlist = create(:bucketlist)
      expect{post :create, bucketlist_id: @bucketlist,
        item: attributes_for(:item)
      }.not_to change(Item, :count)
      expect(response.body).to eq("Sorry you don't have access")
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
      expect(JSON.parse(response.body)["name"]).to eq("Buy House")
      expect(JSON.parse(response.body)["done"]).to eq(true)
      expect(response).to have_http_status(:success)
    end

    it "does not update item if user is not rightful owner of bucketlist" do
      @daisi = create(:user)
      request.headers['AUTHORIZATION'] ="Token token=#{@daisi.auth_token}"
      @bucketlist = create(:bucketlist)
      @item = create(:item)
      put :update, bucketlist_id: @bucketlist, id: @item, item: attributes_for(:item_two)
      expect(response.body).to eq("Item not updated")
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
      expect{ delete :destroy, bucketlist_id: @bucketlist, id: @item }.to change(Item, :count).by(-1)
      expect(response.body).to eq("Item destroyed")
      expect(response).to have_http_status(:success)
    end

    it "delete item if user is not rightful owner" do
      @daisi = create(:user)
      request.headers['AUTHORIZATION'] ="Token token=#{@daisi.auth_token}"
      @bucketlist = create(:bucketlist)
      @item = create(:item)
      expect{ delete :destroy, bucketlist_id: @bucketlist, id: @item }.not_to change(Item, :count)
      expect(response.body).to eq("Item not destroyed")
      expect(response).to have_http_status(:success)
    end
  end

end
