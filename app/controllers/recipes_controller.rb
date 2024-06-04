class RecipesController < ApplicationController
  def index
    @recipes = current_user.recipes.last(3)
  end

  def create
    session[:category] = params[:category] if params[:category]
    # Find ingredients based on [session ingredient_ids]
    ingredient_ids = session[:ingredient_ids]
    meal_type = session[:meal_type]
    category = session[:category]
    #=> #<GlobalID:0x000055988bc4dd20 [...] gid://background-jobs-demo/User/1>>
    serialized_user = current_user.to_global_id.to_s
    AiRecipeGeneratorJob.perform_later(ingredient_ids, meal_type, category, serialized_user)
      # we need to create one ingredient recipe for each ingredient
    redirect_to recipes_path
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def favourite
    @recipe = Recipe.find(params[:id])
    @recipe.update(favourite: !@recipe.favourite)
    @recipe.save
    redirect_to @recipe
  end

  def list_favourites
    @recipes = current_user.recipes.where(favourite: true)
    if params[:query].present?
      @recipes = @recipes.where("title ILIKE ?", "%#{params[:query]}%")
    end
  end

  def delete
    @recipe = Recipe.destroy(params[:id])
    redirect_to @recipes
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :content, :meal_type, :category)
  end
end
