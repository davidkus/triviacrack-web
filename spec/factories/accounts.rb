FactoryBot.define do
  factory :account do
    username    {Faker::Internet.user_name}
    session_id  {Faker::Lorem.characters(number: 20)}
    expiration  {Faker::Time.forward(days: 30)}
    email       {Faker::Internet.email}

    association :user, factory: :user
  end
end
