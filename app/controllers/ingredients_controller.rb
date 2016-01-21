class IngredientsController < ApplicationController

	before_action :set_type, only: [:show, :updateType, :destroyType]
	before_action :set_ingredient, only: [:update, :destroy]

	def index
		if signed_in? && current_user.admin
			set_index
		else
			redirect_to root_path
		end
	end

	def show
		if signed_in? && current_user.admin
			set_show
		else
			redirect_to root_path
		end
	end

	def new
		if signed_in? && current_user.admin
	  		@ingredient = Ingredient.new
	  		@ingredient.ingredient_type_id = params[:ingredient_type_id]
	    else
	      redirect_to root_path
	    end
	end

	def newType
		if signed_in? && current_user.admin
			@type = IngredientType.new
		else
			redirect_to root_path
		end
	end

	def create
	    if signed_in? && current_user.admin
	      set_success(true, "Ingrédient créé avec succès !")
	      @ingredient = Ingredient.new(ingredient_params)
	      if @ingredient.save
	      	@type = @ingredient.ingredient_type
	        set_show
	      else
	        set_success(false, "Erreur lors de la création de l'ingrédient")
	      end
	    else
	      redirect_to root_path
	    end
  	end

  	def createType
	    if signed_in? && current_user.admin
	      set_success(true, "Catégorie créé avec succès !")
	      @type = IngredientType.new(ingredient_type_params)
	      if @type.save
	        set_index
	      else
	        set_success(false, "Erreur lors de la création de la catégorie")
	      end
	    else
	      redirect_to root_path
	    end
  	end

	def update
		if signed_in? && current_user.admin
			@type = IngredientType.find(@ingredient.ingredient_type_id)
			set_success(true, "Modifications enregistrées !")
    		if @ingredient.update(ingredient_params)
    			set_show
    		else
    			set_success(false, "Une erreur est survenue")
    		end
    	else
    		redirect_to root_path
    	end
  	end

  	def updateType
  		if signed_in? && current_user.admin
  			set_success(true, "Modifications enregistrées")
    		if @type.update(ingredient_type_params)
    			set_index
    		else
    			set_success(false, "Une erreur est survenue !")
    		end
		else
			redirect_to root_path
    	end
  	end

  	def destroy
  		if signed_in? && current_user.admin
	      set_success(true, "Ingrédient supprimé !")
	      @type = @ingredient.ingredient_type
	      if @ingredient.destroy
	        set_show
	      else
	        set_success(false, "Une erreur est survenue lors de la suppression")
	      end
	    else
	      redirect_to root_path
	    end
  	end

  	def destroyType
  		if signed_in? && current_user.admin
	      set_success(true, "Catégorie supprimée !")
	      @type.ingredients.each do |ingredient|
	      	if !ingredient.destroy
	      		set_success(false, "Une erreur est survenue lors de la suppression")
	      		return
	      	end
	      end
	      if @type.destroy
	        set_index
	      else
	        set_success(false, "Une erreur est survenue lors de la suppression")
	      end
	    else
	      redirect_to root_path
	    end
  	end

	private

    # Use callbacks to share common setup or constraints between actions.
    def set_type
      @type = IngredientType.find(params[:id])
    end

    def set_ingredient
		@ingredient = Ingredient.find(params[:id])
    end

    def set_index
    	@types = IngredientType.order('name')
    	@type = IngredientType.new
    	@type.name = "Nouvelle catégorie"
    	@type.description = "Description de la catégorie"
    end

    def set_show
    	@ingredients = @type.ingredients
		@ingredient = Ingredient.new
		@ingredient.ingredient_type_id = @type.id
    end

    def ingredient_params
      allow = [:name, :ingredient_type_id]
      params.require(:ingredient).permit(allow)
    end

    def ingredient_type_params
		allow = [:name, :description, :multiple]
		params.require(:ingredient_type).permit(allow)
    end

end
