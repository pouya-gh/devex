class ChangeDigestFormatInPosts < ActiveRecord::Migration
  def change
    change_column :posts, :digest, :text
  end
end
