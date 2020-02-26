FactoryBot.define do
  factory :user do
    email       {Faker::Internet.email}
    password    {Faker::Internet.password}

    factory :user_with_accounts do
      transient do
        account_count { 1 }
      end

      after(:create) do |user, evaluator|
        create_list(:account, evaluator.account_count, user: user)
      end
    end
  end
end
