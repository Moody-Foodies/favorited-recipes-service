class FavoriteRecipeSerializer
  def self.serialize_recipes(favorite_recipes)
    {data: structure_recipes(favorite_recipes)}
  end

  def self.structure_recipes(favorite_recipes)
    favorite_recipes.map do |recipe|
      attributes = {}
      attributes[:name] = recipe.name
      attributes[:description] = recipe.description
      attributes[:time_to_cook] = recipe.time_to_cook
      attributes[:nutrient] = recipe.nutrient
      attributes[:health_benefits] = recipe.health_benefits
      attributes[:image] = recipe.image
      attributes[:ingredients] = recipe.split_ingredients
      attributes[:instructions] = recipe.split_instructions

      serialized_recipe = {}
      serialized_recipe[:id] = recipe.recipe_id
      serialized_recipe[:type] = "recipe"
      serialized_recipe[:attributes] = attributes
      serialized_recipe[:user_id] = recipe.user_id

      serialized_recipe
    end
  end
end
