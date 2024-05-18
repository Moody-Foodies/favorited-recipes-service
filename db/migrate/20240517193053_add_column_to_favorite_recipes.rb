class AddColumnToFavoriteRecipes < ActiveRecord::Migration[7.1]
  def change
    add_column :favorite_recipes, :recipe_id, :integer
  end
end
