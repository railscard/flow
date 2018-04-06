FactoryBot.define do
  factory :user, class: User do
    sequence(:email) {|n| "johndoe-#{n}@gmail.com"}
    password 'password'

    after :create do |user|
      create_list :stream, 10, user: user
      create_list :download, 10, user: user
    end
  end
end
