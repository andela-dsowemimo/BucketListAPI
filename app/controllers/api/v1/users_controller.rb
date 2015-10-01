class Api::V1::UsersController < ApplicationController
  def index
    @users = User.all
    render json: @users
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
  end

  def default_serializer_options
    { root: false }
  end

  private
    def user_params
      params.require(:user).permit(:name, :email)
    end
end
