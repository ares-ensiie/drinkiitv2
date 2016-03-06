class StocksController < ApplicationController
	before_action :set_stock, only: [:update]

	def index
		if signed_in? && current_user.admin
			set_index
		else
			redirect_to root_path
		end
	end

	def update
		set_success(true, "Modifications enregistrées")
		if signed_in? && current_user.admin
			if !@stock.update(stock_params)
				set_success(false, "Une erreur est survenue")
			else
				set_index
			end
		else
			set_success(false, "Vous n'êtes pas autorisé à effectuer cette action")
		end
	end

	private

		def set_stock
			@stock = Stock.find(params[:id])
		end

		def set_index
			if !@stock.nil? && @stock.meal.nil?
				@active = "ingredients"
			else
				@active = "meals"
			end
			@stocks_meal = Stock.where("meal_id IS NOT NULL").order("meal_id")
			@stocks_ingredient = Stock.where("ingredient_id IS NOT NULL").order("ingredient_id")
		end

		def stock_params
			allow = [:quantity, :unit, :auto_update]
      		params.require(:stock).permit(allow)
		end
end
