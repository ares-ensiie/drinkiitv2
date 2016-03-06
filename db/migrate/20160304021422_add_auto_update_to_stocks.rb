class AddAutoUpdateToStocks < ActiveRecord::Migration
  def change
    add_column :stocks, :auto_update, :boolean
  end
end
