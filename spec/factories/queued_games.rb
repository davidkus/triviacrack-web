# == Schema Information
#
# Table name: queued_games
#
#  id         :bigint           not null, primary key
#  game_id    :bigint
#  account_id :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :queued_game do
    game_id     { Faker::Number.number(10) }

    association :account, factory: :account
  end
end
