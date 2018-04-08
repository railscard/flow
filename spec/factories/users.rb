FactoryBot.define do
  factory :user, class: User do
    sequence(:email) {|n| "johndoe-#{n}@gmail.com"}
    password 'password'
  end
end
