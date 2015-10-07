class Api::V1::ItemsController < ApplicationController
  before_action :find_item, only: [:update, :destroy]
  before_action :authenticate_user, only: [:create, :update, :destroy]
  before_action :get_bucketlist, only: [:update, :destroy]

  def_param_group :item do
    param :item, Array, desc: "Item Info"
    param :name, String, "Name of Item"
    param :done, TrueClass, "If Item has been done or not"
    param :bucketlist_id, Fixnum, "ID of Bucketlist that Item belongs to", required: true
  end

  def new
    @item = Item.new
  end

  api :POST, "/v1/bucketlists/:bucketlist_id/items", "Create a Bucketlist ITEM"
  param_group :item, required: true
  def create
    @bucketlist = Bucketlist.find_by(id: params[:id])
    if (@user && @bucketlist) && @bucketlist.user == @user
      @item = Item.create(item_params)
      @bucketlist = Bucketlist.find(params[:id])
      @bucketlist.items << @item
      @bucketlist.save
      render json: @bucketlist
    else
      render json: "Sorry you don't have access"
    end
  end

  api :PUT, "/v1/bucketlists/:bucketlist_id/items/:id", "Update a Specific Bucketlist ITEM"
  param_group :item
  param :id, :number, required: true
  def update
    if (@user && @bucketlist) && @bucketlist.user == @user
      @item.update(item_params)
      render json: @item
    else
      render json: "Item not updated"
    end
  end

  api :DELETE, "/v1/bucketlists/:bucketlist_id/items/:id", "Delete a Specific Bucketlist ITEM"
  param :id, :number, required: true
  def destroy
    if (@user && @bucketlist) && @bucketlist.user == @user
      @item.destroy
      render json: "Item destroyed"
    else
      render json: "Item not destroyed"
    end
  end

  def find_item
    @item = Item.find(params[:id])
  end

  def get_bucketlist
    @bucketlist = Bucketlist.find_by(id: params[:bucketlist_id])
  end

  private
    def item_params
      params.require(:item).permit(:name, :done)
    end
end
