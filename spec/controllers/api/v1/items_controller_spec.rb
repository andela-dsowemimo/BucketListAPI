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
    it "returns http success" do
      @bucketlist = create(:bucketlist)
      post :create, bucketlist_id: @bucketlist, item: attributes_for(:item)
      expect(response).to have_http_status(:success)
    end
  end

  describe "PUT #update" do
    it "returns http success" do
      @bucketlist = create(:bucketlist)
      @item = create(:item)
      put :update, bucketlist_id: @bucketlist, id: @item, item: attributes_for(:item_two)
      expect(response).to have_http_status(:success)
    end
  end

end
