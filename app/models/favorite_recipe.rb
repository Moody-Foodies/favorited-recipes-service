class FavoriteRecipe < ApplicationRecord
  validates :id, :user_id, :name, :description, :nutrient, :health_benefits, :image, :ingredients, :instructions, presence: true
  validates :time_to_cook, presence: true, numericality: true
  validates :id, uniqueness: {scope: :user_id}

  def self.create_new_record(attributes)
    if attributes[:ingredients] && attributes[:instructions]
      attributes[:ingredients] = attributes[:ingredients].join("*separator*")
      attributes[:instructions] = attributes[:instructions].join("*separator*")
    end
    FavoriteRecipe.create!(attributes)
  end

  def split_ingredients
    self.ingredients.split("*separator*")
  end

  def split_instructions
    self.instructions.split("*separator*")
  end
end