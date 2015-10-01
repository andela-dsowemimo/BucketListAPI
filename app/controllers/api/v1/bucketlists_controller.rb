class Api::V1::BucketlistsController < ApplicationController
  def index
    @bucketlists = Bucketlist.all
    render json: @bucketlists
  end

  def new
    @bucketlist = Bucketlist.new
  end

  def create
    @bucketlist = Bucketlist.create(bucketlist_params)
    render json: @bucketlists if @bucketlist.save
  end

  def show

  end

  def destroy

  end

  def default_serializer_options
    { root: false }
  end

  private
  def bucketlist_params
    params.require(:bucketlist).permit(:name)
  end
end
