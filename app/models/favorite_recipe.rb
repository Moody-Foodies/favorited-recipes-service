class FavoriteRecipe < ApplicationRecord
  validates :recipe_id, :user_id, :name, :description, :nutrient, :health_benefits, :image, :ingredients, :instructions, presence: true
  validates :time_to_cook, presence: true, numericality: true
  validates :recipe_id, uniqueness: {scope: :user_id}

  def self.create_new_record(attributes)
    attributes[:recipe_id] = attributes.delete :id
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

  def self.user_favorites(user_id)
    where("user_id = #{user_id}")
  end

  def self.find_single_favorite(user_id, recipe_id)
    where("user_id = #{user_id} AND recipe_id = #{recipe_id}").first
  end
end