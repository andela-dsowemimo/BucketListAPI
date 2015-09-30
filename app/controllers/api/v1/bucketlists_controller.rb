class Api::V1::BucketlistsController < ApplicationController
  def index
    @bucketlists = Bucketlist.all
    render json: @bucketlists, root: false
  end

  def new
    @bucketlist = Bucketlist.new
  end

  def create
    @bucketlist = Bucketlist.create(bucketlist_params)
    render json: @bucketlists, root: false if @bucketlist.save
  end

  def show

  end

  def destroy

  end

  private
  def bucketlist_params
    params.require(:bucketlist).permit(:name)
  end
end
