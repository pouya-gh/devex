class AddFilePathToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :file_path, :string
  end
end
