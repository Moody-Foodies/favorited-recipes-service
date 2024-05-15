require 'rails_helper'

RSpec.describe "Post Request with New Favorite Recipe" do
  before(:each) do
    @headers = { "CONTENT_TYPE" => "application/json" }
    @body = {
      id: 17553, 
      user_id: 1,
      name: "Green Lentil Soup",
      description: "This is a very good soup for winter or fall",
      time_to_cook: 55,
      nutrient: "Magnesium",
      health_benefits: "Magnesium is believed to be able to lower levels of stress and assist in sleep.",
      image: "soup.jpeg",
      ingredients: ["3 medium carrots, peeled and diced", "3 celery stalks, diced", "2 cups fully-cooked chicken breast, shredded (may be omitted for a vegetarian version)", "½ cup flat leaf Italian parsley, chopped (plus extra for garnish)", "6 cloves of garlic, finely minced", "2 tablespoons olive oil", "28 ounce-can plum tomatoes, drained and rinsed, chopped", "2 cups dried red lentils, rinsed", "salt and black pepper, to taste", "1 large turnip, peeled and diced", "8 cups vegetable stock", "1 medium yellow onion, diced"],
      instructions: ["To a large dutch oven or soup pot, heat the olive oil over medium heat.", "Add the onion, carrots and celery and cook for 8-10 minutes or until tender, stirring occasionally.", "Add the garlic and cook for an additional 2 minutes, or until fragrant. Season conservatively with a pinch of salt and black pepper.To the pot, add the tomatoes, turnip and red lentils. Stir to combine. Stir in the vegetable stock and increase the heat on the stove to high. Bring the soup to a boil and then reduce to a simmer. Simmer for 20 minutes or until the turnips are tender and the lentils are cooked through.", "Add the chicken breast and parsley. Cook for an additional 5 minutes. Adjust seasoning to taste.", "Serve the soup immediately garnished with fresh parsley and any additional toppings. Enjoy!"]
    }
  end

  describe '#happy path' do
    it 'can recieve a post request with the correct data and create a new record of the favorite recipe' do
      expect(FavoriteRecipe.all.count).to eq(0)

      post "/api/v1/favorite_recipes", headers: @headers, params: JSON.generate(@body)

      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(FavoriteRecipe.all.count).to eq(1)

      recipe = FavoriteRecipe.find(@body[:id])
      
      expect(recipe.id).to eq(@body[:id])
      expect(recipe.user_id).to eq(@body[:user_id])
      expect(recipe.name).to eq(@body[:name])
      expect(recipe.description).to eq(@body[:description])
      expect(recipe.time_to_cook).to eq(@body[:time_to_cook])
      expect(recipe.nutrient).to eq(@body[:nutrient])
      expect(recipe.health_benefits).to eq(@body[:health_benefits])
      expect(recipe.ingredients).to eq(@body[:ingredients].join("*separator*"))
      expect(recipe.instructions).to eq(@body[:instructions].join("*separator*"))
    end
  end

  describe '#sad path' do
    it '' do

    end
  end
end