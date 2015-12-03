class Ingredient < ActiveRecord::Base
	has_one :ingredient_types
end
