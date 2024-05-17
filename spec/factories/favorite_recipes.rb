FactoryBot.define do
  factory :favorite_recipe do
    id {Faker::Number.number(digits: 5)}
    user_id {1}
    recipe_id {Faker::Number.number(digits: 5)}
    name {Faker::Food.dish}
    description {Faker::Food.description}
    time_to_cook {Faker::Number.number(digits: 5)}
    nutrient {Faker::Food.ingredient}
    health_benefits {Faker::Adjective.positive}
    image {"food.jpeg"}
    ingredients {[Faker::Food.ingredient, Faker::Food.ingredient].join("*separator*")}
    instructions {[Faker::Food.description, Faker::Food.description].join("*separator*")}
  end
end
