class Order < ActiveRecord::Base
	belongs_to :user
	belongs_to :meal
	has_and_belongs_to_many :ingredients
	validates :quantity, presence: true
	validates :user_id, presence: true
	validates :meal_id, presence: true

	def fulldescription
		fulldescription = self.meal.description
		if !self.ingredients.nil? && !self.ingredients.empty?
			fulldescription = fulldescription + " ("
			i = 0
			self.ingredients.each do |ingredient|
				fulldescription = fulldescription + ingredient.name
				if i < self.ingredients.length - 1
					fulldescription = fulldescription + ", "
				end
				i = i + 1
			end
			fulldescription = fulldescription + ")"
		end
		fulldescription
	end

end



