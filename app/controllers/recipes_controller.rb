class RecipesController < ApplicationController
  def create
    session[:category] = params[:category] if params[:category]
    #Find ingredients based on [session ingredient_ids]
    ingredients = Ingredient.where(id:session[:ingredients_ids])
    service = ChatService.new(ingredients, session[:meal_type], session[:category])
    3.times do
      #call the service to get title and content
      #we are going to create the recipe with the meal_type, category, title and content and user
      #we need to create one ingredient recipy for each ingredient
    end

    #redirect the user to the recipe index
  end
end
