class IngredientsController < ApplicationController
  def index
    @ingredients = current_user.ingredients
  end

  def show
    @ingredient = Ingredient.find(params[:id])
  end

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    @ingredient.user = current_user

    if @ingredient.save
      redirect_to @ingredient
    else
      render 'new'
    end
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name, :amount, :measurement)
  end
end
