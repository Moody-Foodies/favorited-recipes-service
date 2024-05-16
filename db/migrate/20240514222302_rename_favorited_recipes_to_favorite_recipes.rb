class RenameFavoritedRecipesToFavoriteRecipes < ActiveRecord::Migration[7.1]
  def change
    rename_table :favorited_recipes, :favorite_recipes
  end
end
