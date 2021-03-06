FactoryBot.define do
  factory :purchase_shipping do
    postal_code       {'123-1234'}
    ship_from_area_id {Faker::Number.within(range: 2..48)}
    municipality      {'漢字'}
    address           {'漢字'}
    building_name     {'テスト荘'}
    phone_number      {'12345678901'}
    token             {"PAYJP_SECRET_KEY"}
  end
end
