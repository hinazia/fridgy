class AiRecipeGeneratorJob < ApplicationJob
  queue_as :default

  def perform(ingredient_ids, meal_type, category, serialized_user)
    # Do something later
    ingredients = Ingredient.where(id: ingredient_ids)
    service= ChatService.new(ingredients, meal_type, category)

    3.times do
      recipe = Recipe.new
      # call the service to get title and content
      title_and_content = service.get_title_and_content
      recipe.title = title_and_content["title"]
      recipe.content = title_and_content["content"]
      # we are going to create the recipe with the meal_type, category, title and content and user
      recipe.meal_type = meal_type
      recipe.category = category
      recipe.user = GlobalID.find(serialized_user)
      if recipe.save
        ingredients.each do |ingredient|
          IngredientRecipe.create(recipe: recipe, ingredient: ingredient )
        end
      end
    end
  end
end
