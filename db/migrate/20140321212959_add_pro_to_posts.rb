class AddProToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :pro, :boolean, default: false
  end
end
