require 'faker'

FactoryGirl.define do
  factory :place do
    name {Faker::Company.name}
    street {Faker::Address.street_address}
    city {Faker::Address.city}
    zip {Faker::Address.zip}
    description {Faker::Lorem.paragraph 2}
    image_url {Faker::Internet.url}
    homepage {Faker::Internet.url}
    telephone {Faker::PhoneNumber.phone_number}
  end
end
