class IngredientsController < ApplicationController
  def index
    @ingredients = current_user.ingredients
    @ingredient = Ingredient.new

  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    @ingredient.user = current_user

    if @ingredient.save
      redirect_to root_path
    end
  end

  def set_meal_type
    session[:ingredients_ids] = params[:ingredients_ids] if params[:ingredients_ids]
  end

  def set_category
    session[:meal_type] = params[:meal_types] if params[:meal_types]
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name, :amount, :measurement)
  end

end
