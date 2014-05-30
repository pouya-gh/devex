class RemoveAdminFromUsers < ActiveRecord::Migration
  def change
  	remove_culumn :users, :admin, :boolean
  end
end
