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
    before :each do
      @daisi = create(:user)
      request.headers['AUTHORIZATION'] ="Token token=#{@daisi.auth_token}"
      @bucketlist = create(:bucketlist)
    end

    after :each do
      expect(response).to have_http_status(:success)
    end

    it "creates item if user is rightful owner of bucketlist" do
      @bucketlist.user = @daisi
      @bucketlist.save
      expect{post :create, bucketlist_id: @bucketlist, item: attributes_for(:item)
      }.to change(Item, :count).by(1)
      expect(JSON.parse(response.body)["name"]).to eq("Things to get done before I turn 30")
      expect(JSON.parse(response.body)["items"][0]["name"]).to eq("Get Married")
      expect(JSON.parse(response.body)["items"][0]["done"]).to eq(false)
    end

    it "does not create item if user is not rightful owner of bucketlist" do
      expect{post :create, bucketlist_id: @bucketlist,
        item: attributes_for(:item)
      }.not_to change(Item, :count)
      expect(response.body).to eq("Sorry you don't have access")
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

    it "updates item if user is rightful owner of bucketlist" do
      @bucketlist.user = @daisi
      @bucketlist.save
      @item = create(:item)
      put :update, bucketlist_id: @bucketlist, id: @item, item: attributes_for(:item_two)
      expect(JSON.parse(response.body)["name"]).to eq("Buy House")
      expect(JSON.parse(response.body)["done"]).to eq(true)
    end

    it "does not update item if user is not rightful owner of bucketlist" do
      @item = create(:item)
      put :update, bucketlist_id: @bucketlist, id: @item, item: attributes_for(:item_two)
      expect(response.body).to eq("Item not updated")
    end
  end

  describe "DELETE #destroy" do
    before :each do
      @daisi = create(:user)
      request.headers['AUTHORIZATION'] ="Token token=#{@daisi.auth_token}"
      @bucketlist = create(:bucketlist)
      @item = create(:item)
    end

    after :each do
      expect(response).to have_http_status(:success)
    end

    it "deletes item if user is rightful owner" do
      @bucketlist.user = @daisi
      @bucketlist.items << @item
      @bucketlist.save
      expect{ delete :destroy, bucketlist_id: @bucketlist, id: @item }.to change(Item, :count).by(-1)
      expect(response.body).to eq("Item destroyed")
    end

    it "delete item if user is not rightful owner" do
      expect{ delete :destroy, bucketlist_id: @bucketlist, id: @item }.not_to change(Item, :count)
      expect(response.body).to eq("Item not destroyed")
    end
  end

end
