class IngredientType < ActiveRecord::Base
	has_many :ingredients
	has_and_belongs_to_many :meals
	validates :name, presence: true
end
