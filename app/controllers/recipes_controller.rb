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
    job =  AiRecipeGeneratorJob.perform_later(ingredient_ids, meal_type, category, serialized_user)
    @job_id = job.provider_job_id

      # we need to create one ingredient recipe for each ingredient
    redirect_to loading_page_path(job_id: @job_id)
  end

  def loading
    @job_id =  params[:job_id] if params[:job_id].present?

  end

  def job_status
    @job_id =  params[:job_id] if params[:job_id].present?
    status = Sidekiq::Status::status(@job_id)
    progress = Sidekiq::Status::pct_complete @job_id
    render json: {status: status, progress: progress}
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
