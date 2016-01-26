class AddTakenToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :taken, :boolean
  end
end
