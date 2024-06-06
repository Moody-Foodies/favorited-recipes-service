class FavoriteRecipe < ApplicationRecord
  validates :recipe_id, :user_id, :name, :description, :nutrient, :health_benefits, :ingredients, :instructions, presence: true
  validates :time_to_cook, presence: true, numericality: true
  validates :recipe_id, uniqueness: {scope: :user_id}

  def self.create_new_record(attributes_info)
    attributes_info[:recipe_id] = attributes_info.delete :id
    if attributes_info[:ingredients] && attributes_info[:instructions] && attributes_info[:instructions].count > 1
      attributes_info[:ingredients] = attributes_info[:ingredients].join("*separator*")
      attributes_info[:instructions] = attributes_info[:instructions].join("*separator*")
    elsif attributes_info[:ingredients] && attributes_info[:instructions] && attributes_info[:instructions].count == 1
      attributes_info[:ingredients] = attributes_info[:ingredients].join("*separator*")
      attributes_info[:instructions] = attributes_info[:instructions].first
    end
    FavoriteRecipe.create!(attributes_info)
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
    where(user_id: user_id, recipe_id: recipe_id).first
  end
end