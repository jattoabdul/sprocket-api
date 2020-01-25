FactoryBot.define do
  factory :product do
    title { %w(SilkscreenPrint BohoMoonBag).sample }
    description { 'A description about the Silkscreen Print Item' }
    country { 'United States' }
    tags { ['black'] }
    price { 12.14 }

    trait :reindex do
      after :create do |product, _evaluator|
        product.reindex(refresh: true)
      end
    end
  end

  factory :invalid_product, parent: :product do
    title { nil }
    price { nil }
  end
end
