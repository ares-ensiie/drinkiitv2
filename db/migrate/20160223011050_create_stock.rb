class CreateStock < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.integer :quantity
      t.string :unit
      t.integer :ingredient_id
      t.integer :meal_id

      t.timestamps null: false
    end
  end

  def self.down
  	drop_table :stocks
  end

end
