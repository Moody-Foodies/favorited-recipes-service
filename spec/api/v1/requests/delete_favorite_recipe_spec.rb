require 'rails_helper'

RSpec.describe 'Delete Favorite Recipe via HTTP Request' do
  before(:each) do
    @headers = {"CONTENT_TYPE" => "application/json"}
    @recipes = create_list(:favorite_recipe, 3, user_id: 1)
    @recipe_1 = FavoriteRecipe.all[0]
    @recipe_2 = FavoriteRecipe.all[1]
    @recipe_3 = FavoriteRecipe.all[2]

    @body = {user_id: @recipe_1.user_id, id: @recipe_1.id}
    @bad_body_1 = {user_id: @recipe_1.user_id, id: 123123123123123}
    @bad_body_2 = {user_id: @recipe_1.user_id}
  end

  describe '#happy path' do
    it 'can delete a favorite recipe for a given user' do
      expect(FavoriteRecipe.all.count).to eq(3)

      delete "/api/v1/favorite_recipes", headers: @headers, params: JSON.generate(@body)

      expect(response).to be_successful
      expect(response.status).to eq(202)

      expect(FavoriteRecipe.all.count).to eq(2)
    end
  end

  describe '#sad path' do
    it 'will respond with the correct error message if the record does not exists' do
      delete "/api/v1/favorite_recipes", headers: @headers, params: JSON.generate(@bad_body_1)

      expect(response).not_to be_successful
      expect(response.status).to eq(404)
      
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to have_key(:errors)
      expect(result[:errors]).to be_a(Hash)
      expect(result[:errors]).to have_key(:detail)
      expect(result[:errors][:detail]).to eq("")
    end

    it 'will respond with the correct error message if the request is missing information' do
      delete "/api/v1/favorite_recipes", headers: @headers, params: JSON.generate(@bad_body_2)

      expect(response).not_to be_successful
      expect(response.status).to eq(422)
      
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to have_key(:errors)
      expect(result[:errors]).to be_a(Hash)
      expect(result[:errors]).to have_key(:detail)
      expect(result[:errors][:detail]).to eq("")
    end
  end
end