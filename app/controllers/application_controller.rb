class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def current_user
  	@current_user ||= User.find_by(id: session[:user_id])
  end

  def set_success(value, message)
    @success = value
    @message = message
  end

  def signed_in?
  	!session[:user_id].nil?
  end

  def get_error_message(errors, model)
    message = ""
    if errors.nil? || errors.empty?
      message = "Un problème inattendu est survenu"
    else
      errors.each do |attribut, msg|
        case model
        when "Category"
          translation = Category.human_attribute_name(attribut)
        when "Ingredient"
          translation = Ingredient.human_attribute_name(attribut)
        when "IngredientType"
          translation = IngredientType.human_attribute_name(attribut)
        when "Meal"
          translation = Meal.human_attribute_name(attribut)
        when "Order"
          translation = Order.human_attribute_name(attribut)
        when "User"
          translation = User.human_attribute_name(attribut)
        end

        message = message + "#{translation} #{msg}"
      end
    end
    message
  end

  helper_method :current_user
  
end
