class RemoveImagePathFromCategories < ActiveRecord::Migration
  def change
    remove_column :categories, :image_path, :string
  end
end
