class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_filter :add_allow_credentials_headers


  def add_allow_credentials_headers
    response.headers["Access-Control-Allow-Origin"] = request.headers["Origin"] || "*"
    response.headers["Access-Control-Allow-Crediantials"] == "true"
  end

  def default_serializer_options
    { root: false }
  end

  def index
    redirect_to "/apipie"
  end

  protected
    def authenticate_user
      authenticate_or_request_with_http_token do |token|
        @user = User.find_by(auth_token: token)
      end
    end

    def current_user
      @current_user ||= User.find_by(id: params[:id])
    end
end
