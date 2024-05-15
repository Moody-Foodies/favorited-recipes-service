FactoryBot.define do
  factory :favorite_recipe do
    id {Faker::Number.numer}
    user_id {1}
    name {Faker::Food.dish}
    description {Faker::Food.description}
    time_to_cook {Faker::Number.number}
    nutrient {Faker::Food.ingredient}
    health_benefits {Faker::Adjective.positive}
    image {"food.jpeg"}
    ingredients {[Faker::Food.ingredient, Faker::Food.ingredient]}
    instructions {[Faker::Food.description, Faker::Food.description]}
  end
end
