FactoryBot.define do
  factory :product do
    title {Faker::Lorem.words}
    content {Faker::Lorem.sentence}
    category_id {2}
    condition_id {2}
    postage_id {2}
    area_id {2}
    shipping_day_id {2}
    price {1000}

    association :user 

    after(:build) do |product|
      product.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
