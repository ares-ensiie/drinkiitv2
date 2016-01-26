class MealsController < ApplicationController
	before_action :set_meal, only: [:update, :destroy]

	def update
	end

	def create
    if signed_in?
      set_success(true, "Plat créé avec succès !")
      @meal = Meal.new(meal_params)
      if !params[:ingredient_types].nil?
        params[:ingredient_types].each do |ingredient|
          @meal.ingredient_types << IngredientType.find(ingredient)
        end
      elsif !@meal.standalone
        set_success(false, "La recette doit comporter au moins un ingrédient !")
        return
      end
      if !@meal.save
        set_success(false, get_error_message(@meal.errors, "Meal"))
      else
        if @meal.standalone
          @display = "standalone"
        else
          @display = "recipe"
        end
        set_menu
      end
    else
      redirect_to root_path
    end
  end

  def destroy
    if signed_in?
      set_success(true, "Plat supprimé !")
      if @meal.standalone
        @display = "standalone"
      else
        @display = "recipe"
      end
      if @meal.destroy
        set_menu
      else
        set_success(false, get_error_message(@meal.errors, "Meal"))
      end
    else
      redirect_to root_path
    end
  end

	private

    # Use callbacks to share common setup or constraints between actions.
    def set_meal
      @meal = Meal.find(params[:id])
    end

    def set_menu
      @category = @meal.category
      @standalones = @category.meals.select { |meal| meal.standalone == true }
      @composed = @category.meals.select { |meal| meal.standalone == false }
      @order = Order.new
      @order.quantity = 1

      # Initialisation des meal pour les lignes d'ajout
      @standalone = Meal.new
      @standalone.category_id = @category.id
      @standalone.standalone = true
      @standalone.price = 1

      @meal = Meal.new
      @meal.category_id = @category.id
      @meal.standalone = false
      @meal.price = 1

      # Récupération des catégories d'ingrédients pour les potentielles nouvelles recettes
      @ingredient_types = IngredientType.order('name')
    end

    def meal_params
      allow = [:description, :price, :category_id, :standalone]
      params.require(:meal).permit(allow)
    end
end