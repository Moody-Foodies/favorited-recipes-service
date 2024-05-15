class FavoriteRecipe < ApplicationRecord
  validates :id, :user_id, :name, :description, :nutrient, :health_benefits, :image, :ingredients, :instructions, presence: true
  validates :time_to_cook, presence: true, numericality: true

  def self.create_new_record(attributes)
    attributes[:ingredients] = attributes[:ingredients].join("*separator*")
    attributes[:instructions] = attributes[:instructions].join("*separator*")
    FavoriteRecipe.create!(attributes)
  end
end

# will need to turn the ingredients and instructions back into arrays in the serializer before sending the recipe back to the gateway