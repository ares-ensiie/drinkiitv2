require 'fileutils'
class CategoriesController < ApplicationController
	before_action :set_category, only: [:show, :update, :destroy]

	def index
		if signed_in?
			set_index
		else
			redirect_to root_path
		end
	end

	def show
		if signed_in?
			@order = Order.new
			@order.quantity = 1
			@order.user_id = current_user.id
			@standalones = @category.meals.select { |meal| meal.standalone == true }
			@composed = @category.meals.select { |meal| meal.standalone == false }

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
		else
			redirect_to root_path
		end
	end

	def update
		if signed_in? && current_user.admin
			set_success(true, "Modifications enregistrées !")
  		if @category.update(category_params)
  			set_index
  		else
  			set_success(false, get_error_message(@category.errors, "Category"))
  		end
		else
			redirect_to root_path  		
  	end
  end

	def create
		if signed_in? && current_user.admin
		set_success(true, "Catégorie créée !")
		@category = Category.new(category_params)
		if @category.save
			set_index
		else
			set_success(false, get_error_message(@category.errors, "Category"))
		end    
	else
		redirect_to root_path	
  	end
	end

	def destroy
		if signed_in? && current_user.admin
			set_success(true, "Catégorie supprimée !")
			@category.meals.each do |meal|
				meal.destroy
			end
			if @category.destroy
				set_index
			else
				set_success(false, get_error_message(@category.errors, "Category"))
			end
		else
			redirect_to root_path
		end
	end

	private

    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    def set_index
    	@categories = Category.order('name')
    	@category = Category.new
    	@category.name = "Nouvelle catégorie"
    	@category.description = "Description de la catégorie"
    end

    def category_params
      allow = [:name, :description, :image]
      params.require(:category).permit(allow)
    end
end