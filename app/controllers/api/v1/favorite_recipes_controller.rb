class Api::V1::FavoriteRecipesController < ApplicationController
  def create
    recipe = FavoriteRecipe.create_new_record(recipe_data)
    render json: {}, status: 201
  end

  def index
    recipes = FavoriteRecipe.user_favorites(params[:user_id])
    render json: FavoriteRecipeSerializer.serialize_recipes(recipes)
  end

  private
  def recipe_data
    params.permit(:id, :user_id, :name, :description, :time_to_cook, :nutrient, :health_benefits, :image, ingredients: [], instructions: [])
  end
end