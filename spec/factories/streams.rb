FactoryBot.define do
  factory :stream do
    name { Faker::Lovecraft.tome }
    code { Faker::Lovecraft.tome }

    user
  end
end
