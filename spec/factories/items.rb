FactoryBot.define do
  factory :item do
    image              {Faker::Lorem.sentence}
    name               {Faker::Lorem.sentence}
    description        {Faker::Lorem.sentence}
    category_id        {Faker::Number.within(range: 2..11)}
    condition_id       {Faker::Number.within(range: 2..7)}
    shipping_charge_id {Faker::Number.within(range: 2..3)}
    ship_from_area_id  {Faker::Number.within(range: 2..48)}
    days_to_ship_id    {Faker::Number.within(range: 2..4)}
    price              {Faker::Number.within(range: 300..9999999)}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.jpg'), filename: 'test_image.jpg')
    end
  end
end
