class Ingredient < ActiveRecord::Base
	belongs_to :ingredient_type
	has_and_belongs_to_many :orders
	has_one :stock
	validates :name, presence: true
	validates :ingredient_type_id, presence: true

	def hasStock?
		res = (self.stock.quantity > 0)
	end
end
