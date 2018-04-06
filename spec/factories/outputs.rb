FactoryBot.define do
  factory :output do
    sequence(:line)
    content { Faker::Lorem.sentence }
    responce 'success'

    trait :error do
      responce 'error'
    end

    download
    stream
  end
end
