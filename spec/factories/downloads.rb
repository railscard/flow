FactoryBot.define do
  factory :download do
    name { Faker::Lovecraft.tome }
    
    user
  end
end
