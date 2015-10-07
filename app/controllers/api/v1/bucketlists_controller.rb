class Api::V1::BucketlistsController < ApplicationController
  before_action :authenticate_user, only: [:create, :show, :update, :destroy]
  before_action :find_bucketlist, only: [:show, :update, :destroy]
  # before_action :current_user, only: [:create]

  def_param_group :bucketlist do
    param :bucketlist, Hash, desc: "Bucketlist Info", required: true do
      param :name, String, "Name of the Bucketlist"
      param :user_id, Fixnum, "ID of User that owns Bucketlist"
    end
  end

  #===============Index action API Documentation==============
  api :GET, "/v1/bucketlists", "Show a list of All Bucketlists"
  #===========================================================

  def index
    @bucketlists = Bucketlist.all
    render json: @bucketlists, status: :ok
  end

  def new
    @bucketlist = Bucketlist.new
  end

  #==========Create action API Documentation==========
  api :POST, "/v1/bucketlists/", "Create a Bucketlist"
  param_group :bucketlist, required: true
  #===================================================

  def create
    if @user == User.find_by(email: params[:email])
      @bucketlist = Bucketlist.create(bucketlist_params)
      @user.bucketlists << @bucketlist
      @user.save
      render json: @bucketlist
    else
      render json: "You don't have access to create bucketlists for other users"
    end
  end

  #===============Show action API Documentation===============
  api :GET, "/v1/bucketlists/:id", "Show a specific Bucketlist"
  param :id, :number, required: true
  #===========================================================

  def show
    if (@user && @bucketlist) && @bucketlist.user == @user
      render json: @bucketlist
    else
      render json: "You cannot view this bucketlist"
    end
  end

  #===============Update action API Documentation===============
  api :PUT, "/v1/bucketlists/:id", "Update a specific Bucketlist"
  param :id, :number, required: true
  param_group :bucketlist
  #=============================================================

  def update
    if (@user && @bucketlist) && @bucketlist.user == @user
      @bucketlist.update(bucketlist_params)
      render json: @bucketlist
    else
      render json: "You cannot update this bucketlist"
    end
  end

  #===============Delete action API Documentation===============
  api :DELETE, "/v1/bucketlists/:id", "Delete a Specific Bucketlist"
  param :id, :number, required: true
  #================================================================

  def destroy
    if (@user && @bucketlist) && @bucketlist.user == @user
      @bucketlist.destroy
      render json: "You have Successfully Deleted the Bucketlist"
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
