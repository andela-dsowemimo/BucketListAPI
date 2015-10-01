class User < ActiveRecord::Base
  before_create :set_auth_token
  has_many :bucketlists

  private
    def set_auth_token
      return if auth_token.present?
      self.auth_token = generate_auth_token
    end

    def generate_auth_token
      begin
        self.auth_token = SecureRandom.uuid.gsub(/\-/, "")
      end while self.class.exists?(auth_token: auth_token)
      self.auth_token
    end
end
