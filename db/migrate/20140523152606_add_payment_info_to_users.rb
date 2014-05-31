class AddPaymentInfoToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :last_payment, :date
  	add_column :users, :subscribed_until, :date
  end
end
