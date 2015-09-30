class AddBucketlistToItems < ActiveRecord::Migration
  def change
    add_reference :items, :bucketlist, index: true, foreign_key: true
  end
end
