class Api::V1::AuthorizationsController < ApplicationController
  before_action :find_user, only: [:create]
  before_action :authenticate_user, only: [:destroy]
#
  def create
    if @user && @user.authenticate(params[:password])
      @user.set_auth_token
      @user.save
      render json: @user
    else
      render json: "Invalid Email or Password"
    end
  end

  def destroy
    @user.auth_token = nil
    @user.save
    render json: "You have Successfully Logged Out"
  end

  private
    def current_user
      @current_user ||= User.find_by(id: params[:user_id])
    end

    def find_user
      @user = User.find_by(email: params[:email])
    end
end
