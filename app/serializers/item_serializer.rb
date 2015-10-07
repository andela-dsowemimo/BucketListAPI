class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :done, :created_at, :updated_at, :bucketlist_id

  attribute :id, :key => :item_id
  
end
