FactoryBot.define do
  factory :product do
    title { %w(SilkscreenPrint BohoMoonBag).sample }
    description { Faker::Lorem.sentence(word_count: 1) }
    country { 'United States' }
    tags { [] }
    price { 12.14 }
  end
end
