class Api::V1::FavoriteRecipesController < ApplicationController
  before_action :get_user_id, only: [:index]

  def create
    recipe = FavoriteRecipe.create_new_record(recipe_data)
    render json: {}, status: 201
  end

  def index
    recipes = FavoriteRecipe.user_favorites(@user_id)
    render json: FavoriteRecipeSerializer.serialize_recipes(recipes)
  end

  def destroy
    recipe = FavoriteRecipe.find_single_favorite(params[:user_id], params[:id])
    if recipe
      recipe.delete
      render json: {}, status: 202
    else
      render json: ErrorMessageSerializer.serialize_json(ErrorMessage.new("No favorited recipe found with that combination of user and recipe id.")), status: 404
    end
  end

  private
  def get_user_id
    @user_id = params[:user_id]
    unless @user_id
      message = "Unable to process request due to missing information"
      render json: ErrorMessageSerializer.serialize_json(ErrorMessage.new(message)), status: :bad_request
    end
  end

  def recipe_data
    params.permit(:id, :user_id, :name, :description, :time_to_cook, :nutrient, :health_benefits, :image, ingredients: [], instructions: [])
  end
end