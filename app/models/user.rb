class User < ActiveRecord::Base
  has_many :bucketlists
end
