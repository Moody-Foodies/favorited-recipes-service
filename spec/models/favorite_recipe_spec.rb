require 'rails_helper'

RSpec.describe FavoriteRecipe do
  describe 'Validations' do
    it { should validate_presence_of(:id) }
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
  end
end