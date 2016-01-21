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
    			set_success(false, "Une erreur est survenue !")
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
    			set_success(false, "Une erreur est survenue !")
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
  				set_success(false, "Une erreur est survenue !")
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
      allow = [:name, :description]
      params.require(:category).permit(allow)
    end

end