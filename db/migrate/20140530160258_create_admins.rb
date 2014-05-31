class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
    	t.string :first_name
    	t.string :last_name
    	t.string :email
    	t.string :password_digest
    	t.string :auth_token
    	t.string :phone_number

      t.timestamps
    end
    add_index :admins, :email, 			unique: true
    add_index :admins, :auth_token, unique: true
  end
end
