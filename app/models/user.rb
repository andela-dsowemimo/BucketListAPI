class User < ActiveRecord::Base
  before_create :set_auth_token, :downcase_email
  has_many :bucketlists
  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
   format: { with: VALID_EMAIL_REGEX }
  #  , uniqueness: {case_sensitive: false}

  def set_auth_token
    return if auth_token.present?
    self.auth_token = generate_auth_token
  end

  private
    def generate_auth_token
      # begin
        SecureRandom.uuid.gsub(/\-/, "")
      # end while self.class.exists?(auth_token: self.auth_token)
    end

    def downcase_email
      self.email = email.downcase
    end
end
