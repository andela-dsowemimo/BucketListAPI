class Bucketlist < ActiveRecord::Base
  belongs_to :user
  has_many :items

  # def as_json(options = nil)
  #   super({include: [:items, :user] }).tap{ |hash|
  #     hash["created_by"] = hash['user']['name']
  #     hash.delete 'user_id'
  #     hash.delete 'user'
  #   }
  #
  # end
end
