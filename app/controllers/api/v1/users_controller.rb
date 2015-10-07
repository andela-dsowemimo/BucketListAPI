require "securerandom"

class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user, only: [:show, :update]
  before_action :current_user, only: [:show, :update]

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

  def show
    if @user == @current_user
      render json: @user
    else
      render json: "You cannot view that page"
    end
  end

  def update
    if @user == @current_user
      @user.update(user_params)
    else
      render json: "You cannot view that page"
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email)
    end
end
