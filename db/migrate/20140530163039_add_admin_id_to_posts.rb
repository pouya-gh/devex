class AddAdminIdToPosts < ActiveRecord::Migration
  def change
  	add_culumn :posts, :admin_id, :integer
  end
end
