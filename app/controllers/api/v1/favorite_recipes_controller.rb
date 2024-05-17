class Api::V1::FavoriteRecipesController < ApplicationController
  before_action :get_user_id, only: [:index]

  def create
    recipe = FavoriteRecipe.create_new_record(recipe_data)
    render json: {}, status: 201
  end

  def index
    recipes = FavoriteRecipe.user_favorites(params[:user_id])
    render json: FavoriteRecipeSerializer.serialize_recipes(recipes)
  end

  private
  def get_user_id
    @user_id = params[:user_id]
    unless @user_id
      message = "User ID not provided in request query. Please include a user_id"
      render json: ErrorMessageSerializer.serialize_json(ErrorMessage.new(message)), status: :bad_request
    end
  end

  def recipe_data
    params.permit(:id, :user_id, :name, :description, :time_to_cook, :nutrient, :health_benefits, :image, ingredients: [], instructions: [])
  end
end