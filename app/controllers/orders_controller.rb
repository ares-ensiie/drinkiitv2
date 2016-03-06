class OrdersController < ApplicationController
before_action :set_order, only: [:take, :validate, :destroy_in_orders, :destroy_in_my_orders]

	def index
		if signed_in? && current_user.admin
			set_order_list
		else
			redirect_to root_path
		end
	end

	def refresh
		set_order_list
	end

	def show
		if signed_in?
			set_my_orders
		else
			redirect_to root_path
		end
	end

	def create
		set_success(true, "Commande effectuée avec succès !")
		if signed_in?
		    @order = Order.new(order_params)		    
		    @meal = Meal.find(@order.meal_id)
		    if @order.quantity.nil?
		    	set_success(false, "La quantité doit être rempli(e)")
		    	return
		    elsif @order.quantity < 1
		    	set_success(false, "La quantité doit être au moins égale à 1 !")
		    	return
		    end
		    @order.total = @order.quantity * @meal.price
		    @order.taken = false

		    if !params[:ingredients].nil?
		    	params[:ingredients].each do |type_id, ingredient_id|
		    		if ingredient_id.empty? || ingredient_id.nil?
		    			set_success(false, IngredientType.find(type_id).name + " non renseigné(e) !")
		    			return
		    		else
		    			@order.ingredients << Ingredient.find(ingredient_id)
		    		end
		    	end
		    end
		    if current_user.solde - @order.total >= 0
		    	if check_user_for(@order)			    
				    @order.served = false
				    @order.ordered_at = DateTime.now
				    if !@order.save
				    	set_success(false, get_error_message(@order.errors, "Order"))
			    	end
				else
					set_success(false, "Erreur d'authentification !")
				end
			else
				set_success(false, "Vous n'avez pas assez d'argent !")
		    end 
		else
			redirect_to root_path
		end
  	end

  	def validate
  		set_success(true, "Commande archivée !")
  		if @order.meal.standalone
	  		stock = @order.meal.stock
	  		if stock.auto_update
	  			stock.update_attribute('quantity', stock.quantity - @order.quantity)
	  		end
	  	else
	  		@order.meal.ingredients.each do |ingredient|
	  			if ingredient.stock.auto_update
	  				ingredient.stock.update_attribute('quantity', ingredient.stock.quantity - @order.quantity)
	  			end
	  		end
	  	end
  		@user = @order.user
  		new_solde = @user.solde - @order.total
  		if !(@user.update_attribute('solde', new_solde) && @order.update_attribute('served', true))
  			if @user.errors.any?
  				set_success(false, get_error_message(@user.errors, "User"))
  			else
  				set_success(false, get_error_message(@order.errors, "Order"))
  			end
  		else
  			set_order_list
		end
  	end

  	def take
  		@order.update_attribute('taken', order_params[:taken])
  	end

  	def destroy_in_orders
  		if signed_in? && current_user.admin
	  		set_success(true, "Commande supprimée !")
	  		if !@order.destroy
	  			set_success(false, get_error_message(@order.errors, "Order"))
	  		else
	  			set_order_list
	  		end
	  	else
	  		redirect_to root_path
	  	end
  	end

  	def destroy_in_my_orders
  		if signed_in?
	  		set_success(true, "Commande supprimée !")
	  		if !@order.destroy
	  			set_success(false, get_error_message(@order.errors, "Order"))
	  		else
	  			set_my_orders
	  		end
	  	else
	  		redirect_to root_path
	  	end
  	end
	private

	def set_order
		@order = Order.find(params[:id])
	end

	def set_order_list
		@orders = Order.order('ordered_at DESC')
		@today = @orders.select { |order| order.served == false && order.ordered_at.to_date == DateTime.now.to_date }
		@historique = @orders.select { |order| order.served == true || order.ordered_at.to_date != DateTime.now.to_date }
	end

	def set_my_orders
		@notserved = current_user.orders.select { |order| order.served == false }
		@served = current_user.orders.select { |order| order.served == true }
	end

	def check_user_for(order)
		status = current_user.id == order.user_id
	end

	def order_params
      allow = [:quantity, :meal_id, :user_id, :comment, :taken]
      params.require(:order).permit(allow)
    end
end
