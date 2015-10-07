class Api::V1::ItemsController < ApplicationController
  before_action :find_item, only: [:update, :destroy]
  before_action :authenticate_user, only: [:create]

  def new
    @item = Item.new
  end

  def create
    if @user
      @item = Item.create(item_params)
      @bucketlist = Bucketlist.find(params[:id])
      @bucketlist.items << @item
      @bucketlist.save
      render json: @bucketlist
    else
      render json: "Sorry you don't have access"
    end
  end

  def update
    @item.update(item_params)
  end

  def destroy

  end

  def find_item
    @item = Item.find(params[:id])
  end

  private
    def item_params
      params.require(:item).permit(:name, :done)
    end
end
