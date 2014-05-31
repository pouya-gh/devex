class RemoveUserIdFromPosts < ActiveRecord::Migration
  def change
  	remove_column :posts, :user_id, :integer
  end
end
