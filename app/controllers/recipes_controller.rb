class RecipesController < ApplicationController
  def index
    @recipes = current_user.recipes.last(3)
  end

  def create
    session[:category] = params[:category] if params[:category]
    # Find ingredients based on [session ingredient_ids]
    ingredients = Ingredient.where(id: session[:ingredients_ids])
    service = ChatService.new(ingredients, session[:meal_type], session[:category])
    3.times do
      recipe = Recipe.new
      # call the service to get title and content
      title_and_content = service.get_title_and_content
      recipe.title = title_and_content["title"]
      recipe.content = title_and_content["content"]
      # we are going to create the recipe with the meal_type, category, title and content and user
      recipe.meal_type = session[:meal_type]
      recipe.category = session[:category]
      recipe.user = current_user
      # we need to create one ingredient recipe for each ingredient
      if recipe.save
        ingredients.each do |ingredient|
          IngredientRecipe.create(recipe: recipe, ingredient: ingredient )
        end
      end
    end

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
