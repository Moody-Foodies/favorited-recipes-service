class Api::V1::FavoriteRecipesController < ApplicationController
  def create
    FavoriteRecipe.create!(recipe_data)
    render json: {data: "Recipe added to favorites"}, status: 201
  end

  private
  def recipe_data
    params.permit(
      :id,
      :user_id,
      :name,
      :description,
      :time_to_cook,
      :nutrient,
      :health_benefits,
      :ingredients,
      :instructions
    )
  end
end