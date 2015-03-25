FactoryGirl.define do
  factory :queued_game do
    game_id     Faker::Number.number(10)

    association :account, factory: :account
  end
end
