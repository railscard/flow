FactoryBot.define do
  factory :input do
    sequence(:line)
    content { Faker::Lorem.sentence }

    download
  end
end
