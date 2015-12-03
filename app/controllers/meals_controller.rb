class MealsController < ApplicationController
	before_action :set_meal, only: [:update, :destroy]

	def new
		@meal = Meal.new
		@meal.category_id = params[:category_id]
		@meal.standalone = params[:standalone]
	end

	def update
	end

	def create   
    @meal = Meal.new(meal_params)
    @meal.save
    set_menu
  end

  def destroy
    set_menu
    @meal.destroy
  end

	private

    # Use callbacks to share common setup or constraints between actions.
    def set_meal
      @meal = Meal.find(params[:id])
    end

    def set_menu
      @standalones = Meal.get_standalones_for(@meal.category_id)
      @composed = Meal.get_composed_meals_for(@meal.category_id)
      @order = Order.new
      @order.quantity = 1
      @category = Category.find(@meal.category_id)
    end

    def meal_params
      allow = [:description, :price, :category_id, :standalone]
      params.require(:meal).permit(allow)
    end

end