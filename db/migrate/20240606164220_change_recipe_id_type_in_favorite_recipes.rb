class ChangeRecipeIdTypeInFavoriteRecipes < ActiveRecord::Migration[7.1]
  def change
    change_column :favorite_recipes, :recipe_id, :string
  end
end
