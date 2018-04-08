FactoryBot.define do
  factory :output do
    sequence(:line)
    content { Faker::Lorem.sentence }

    download
  end
end
