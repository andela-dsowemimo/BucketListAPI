class BucketlistSerializer < ActiveModel::Serializer
  attributes :id, :name, :items, :created_at, :updated_at, :user
  has_many :items

  attribute :created_at, :key => :date_created
  attribute :updated_at, :key => :date_modified
  attribute :user, :key => :created_by

  def user
    object.user.name if object.user
  end

end
