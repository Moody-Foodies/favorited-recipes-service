require 'rails_helper'

RSpec.describe FavoriteRecipe do
  describe 'Validations' do
    it { should validate_presence_of(:id) }
    it { should validate_presence_of(:recipe_id) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:time_to_cook) }
    it { should validate_numericality_of(:time_to_cook) }
    it { should validate_presence_of(:nutrient) }
    it { should validate_presence_of(:health_benefits) }
    it { should validate_presence_of(:image) }
    it { should validate_presence_of(:ingredients) }
    it { should validate_presence_of(:instructions) }
  end

  describe '.class methods' do
    describe '.create_new_record' do
      it 'joins the arrays that come with instructions and ingredients before storing them as attributes and creating the db record' do
        attributes = {
          id: 1,
          recipe_id: 17553, 
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
        joined_ingredients = attributes[:ingredients].join("*separator*")
        joined_instructions = attributes[:instructions].join("*separator*")

        recipe = FavoriteRecipe.create_new_record(attributes)

        expect(recipe.ingredients).to be_a(String)
        expect(recipe.ingredients).to eq(joined_ingredients)
        expect(recipe.instructions).to be_a(String)
        expect(recipe.instructions).to eq(joined_instructions)
        expect(recipe).to be_a(FavoriteRecipe)
      end
    end

    describe '.user_favorites(user_id)' do
      it 'finds all favorited recipes for a given user' do
        recipes = create_list(:favorite_recipe, 3)

        expect(FavoriteRecipe.user_favorites(1).count).to eq(3)
        expect(FavoriteRecipe.user_favorites(1)).to match_array(recipes)
      end
    end
  end

  describe '#instance methods' do
    describe '#split_ingredients' do
      it 'will split the ingredients string at the separators and return an array of strings with each ingredient listed' do
        recipe = create(:favorite_recipe)

        expect(recipe.ingredients).to be_a(String)

        expect(recipe.split_ingredients).to be_a(Array)
        expect(recipe.split_ingredients.count).to eq(2)
        expect(recipe.split_ingredients.first).to be_a(String)
        expect(recipe.split_ingredients.last).to be_a(String)
      end
    end

    describe '#split_instructions' do
      it 'will split the instructions string at the separators and return an array of strings with each instruction listed' do
        recipe = create(:favorite_recipe)

        expect(recipe.instructions).to be_a(String)

        expect(recipe.split_instructions).to be_a(Array)
        expect(recipe.split_instructions.count).to eq(2)
        expect(recipe.split_instructions.first).to be_a(String)
        expect(recipe.split_instructions.last).to be_a(String)
      end
    end
  end
end