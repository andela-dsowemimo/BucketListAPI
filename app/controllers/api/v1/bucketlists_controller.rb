class Api::V1::BucketlistsController < ApplicationController
  before_action :authenticate_user, only: [:create, :show, :update, :destroy]
  before_action :find_bucketlist, only: [:show, :update, :destroy]
  # before_action :current_user, only: [:create]

  def index
    @bucketlists = Bucketlist.all
    render json: @bucketlists, status: :ok
  end

  def new
    @bucketlist = Bucketlist.new
  end

  def create
    if @user
      @bucketlist = Bucketlist.create(bucketlist_params)
      @user.bucketlists << @bucketlist
      @user.save
      render json: @bucketlist
    else
      render json: "You don't have access to create bucketlists for other users"
    end
  end

  def show
    if (@user && @bucketlist) && @bucketlist.user == @user
      render json: @bucketlist
    else
      render json: "You cannot view this bucketlist"
    end
  end

  def update
    if (@user && @bucketlist) && @bucketlist.user == @user
      @bucketlist.update(bucketlist_params)
      render json: @bucketlist
    else
      render json: "You cannot update this bucketlist"
    end
  end

  def destroy
    if (@user && @bucketlist) && @bucketlist.user == @user
      @bucketlist.destroy
    else
      render json: "You do not have the right to delete this bucketlist"
    end
  end

  def find_bucketlist
    @bucketlist = Bucketlist.find_by(id: params[:id])
  end

  private
  def bucketlist_params
    params.require(:bucketlist).permit(:name)
  end
end
