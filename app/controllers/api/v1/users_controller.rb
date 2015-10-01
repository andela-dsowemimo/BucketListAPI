class Api::V1::UsersController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authenticate, only: [:index]

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

  protected
    def authenticate
      authenticate_or_request_with_http_token do |token|
        User.find_by(auth_token: token)
      end
    end

  private
    def user_params
      params.require(:user).permit(:name, :email)
    end
end
