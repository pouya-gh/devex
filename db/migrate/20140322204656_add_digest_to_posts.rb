class AddDigestToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :digest, :string
  end
end
