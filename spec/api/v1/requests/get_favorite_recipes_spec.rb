require 'rails_helper'

RSpec.describe "Get Favorite Recipes via GET HTTP Request" do
  before(:each) do
    @headers = {"CONTENT_TYPE" => "application/json"}
    @recipes = create_list(:favorite_recipe, 3, user_id: 1)
    @recipe_2 = create(:favorite_recipe, user_id: 2)
  end

  describe '#happy path' do
    it 'can return all the favorite recipes for a specific user_id' do
      get "/api/v1/favorite_recipes?user_id=1", headers: @headers

      expect(response).to be_successful
      expect(response.status).to eq(200)

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to have_key(:data)
      expect(result[:data]).to be_a(Array)
      expect(result[:data].count).to eq(3)
      expect(FavoriteRecipe.all.count).to eq(4)

      data = result[:data]

      data.each do |recipe|
        expect(recipe).to have_key(:id)
        expect(recipe[:id]).to be_a(String)
        expect(recipe).to have_key(:type)
        expect(recipe[:type]).to be_a(String)
        expect(recipe).to have_key(:attributes)
        expect(recipe[:attributes]).to be_a(Hash)

        attributes = recipe[:attributes]

        expect(attributes).to have_key(:name)
        expect(attributes[:name]).to be_a(String)
        expect(attributes).to have_key(:description)
        expect(attributes[:description]).to be_a(String)
        expect(attributes).to have_key(:time_to_cook)
        expect(attributes[:time_to_cook]).to be_a(Integer)
        expect(attributes).to have_key(:nutrient)
        expect(attributes[:nutrient]).to be_a(String)
        expect(attributes).to have_key(:health_benefits)
        expect(attributes[:health_benefits]).to be_a(String)
        expect(attributes).to have_key(:image)
        expect(attributes[:image]).to be_a(String)
        expect(attributes).to have_key(:ingredients)
        expect(attributes[:ingredients]).to be_a(Array)
        expect(attributes[:ingredients].all?(String)).to eq(true)
        expect(attributes).to have_key(:instructions)
        expect(attributes[:instructions]).to be_a(Array)
        expect(attributes[:instructions].all?(String)).to eq(true)
      end
    end
  end

  describe "#sad path" do
    it 'return appropriate response if the user_id is missing from the query' do
      get "/api/v1/favorite_recipes", headers: @headers

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      result = JSON.parse(response.body, symbolize_names: true)
      
      expect(result).to have_key(:errors)
      expect(result[:errors]).to be_a(Hash)
      expect(result[:errors]).to have_key(:detail)
      expect(result[:errors][:detail]).to eq("Unable to process request due to missing information")
    end

    it 'return appropriate response if the user_id passed has no recipes yet' do
      get "/api/v1/favorite_recipes?user_id=3", headers: @headers

      expect(response).to be_successful
      expect(response.status).to eq(200)

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to have_key(:data)
      expect(result[:data]).to be_a(Array)
      expect(result[:data]).to be_empty
    end
  end
end
