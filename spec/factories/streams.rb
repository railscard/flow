FactoryBot.define do
  factory :stream do
    name { Faker::Lovecraft.tome }
    code { File.read(Rails.root.join('spec/support/fixtures/valid.js')) }

    user

    trait :invalid_code do
      code { File.read(Rails.root.join('spec/support/fixtures/invalid.js')) }
    end

    trait :wrong_variable do
      code { File.read(Rails.root.join('spec/support/fixtures/wrong_variable.js')) }
    end
  end
end
