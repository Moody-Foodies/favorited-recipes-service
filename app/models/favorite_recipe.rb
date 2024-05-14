class FavoriteRecipe < ApplicationRecord
  validates :id, :user_id, :name, :description, :nutrient, :health_benefits, :image, :ingredients, :instructions, presence: true
  validates :time_to_cook, presence: true, numericality: true
end