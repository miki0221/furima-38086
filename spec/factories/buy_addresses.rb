FactoryBot.define do
  factory :buy_address do
    postcode { '123-4567' }
    area_id { 2 }
    municipality { '横浜市緑区'}
    address { '青山1-1-1' }
    phone {'09012345678'}

  end
end
