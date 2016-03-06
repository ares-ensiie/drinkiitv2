class AddAvailableToMeals < ActiveRecord::Migration
  def change
    add_column :meals, :available, :boolean
  end
end
