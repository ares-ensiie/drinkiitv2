class Ingredient < ActiveRecord::Base
	belongs_to :ingredient_type
	has_and_belongs_to_many :orders
	validates :name, presence: true
	validates :ingredient_type_id, presence: true
end
