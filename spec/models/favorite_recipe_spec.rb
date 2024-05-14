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
end