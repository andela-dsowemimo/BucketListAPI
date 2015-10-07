require "securerandom"

class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user, only: [:show, :update]
  before_action :current_user, only: [:show, :update]

  def_param_group :user do
    param :user, Hash, desc: "User Info", required: true do
      param :name, String, "Name of the user"
      param :email, String, "Email of the User"
      param :password, String, "Password of the User"
      param :password_confirmation, String, "Password Confirmation of the User"
    end
  end

  api :GET, "/v1/users", "Show a list of All Users"
  def index
    @users = User.all
    render json: @users
  end

  def new
    @user = User.new
  end

  api :POST, "/v1/users", "Create a User"
  param_group :user, required: true
  def create
    @user = User.create(user_params)
  end

  api :GET, "/v1/users/:id", "Show a specific User"
  param :id, :number, required: true
  def show
    if @user == @current_user
      render json: @user
    else
      render json: "You cannot view that page"
    end
  end

  api :PUT, "/v1/users/:id", "Update a specific User"
  param :id, :number, required: true
  param_group :user
  def update
    if @user == @current_user
      @user.update(user_params)
    else
      render json: "You cannot view that page"
    end
  end

  api :DELETE, "/v1/users/:id", "Delete a user"
  param :id, :number, required: true
  def destroy
    if @user == @current_user
      @user.destroy
    else
      render json: "Not authorized"
    end
  end


  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end


end
