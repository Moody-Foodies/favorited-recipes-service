class CreateFavoritedRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :favorited_recipes do |t|
      t.string :name
      t.string :description
      t.integer :time_to_cook
      t.string :nutrient
      t.string :health_benefits
      t.string :image
      t.string :ingredients
      t.string :instructions

      t.timestamps
    end
  end
end
