class Meal < ActiveRecord::Base
	belongs_to :category
	has_many :orders
	has_and_belongs_to_many :ingredient_types
	has_one :stock
	validates :description, presence: true
	validates :price, presence: true

	def hasStock?
		res = true
		if self.standalone
			res = (self.stock.quantity > 0)
		end
		res
	end

	class << self

		def get_standalones_for(category_id)
			self.where("category_id = ? AND standalone = true", category_id)
		end

		def get_composed_meals_for(category_id)
			self.where("category_id = ? AND standalone = false", category_id)
		end
	end
end
