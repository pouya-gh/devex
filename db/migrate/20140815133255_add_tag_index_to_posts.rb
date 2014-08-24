class AddTagIndexToPosts < ActiveRecord::Migration
  def change
    add_index :posts, :tags, using: 'gin'
  end
end
