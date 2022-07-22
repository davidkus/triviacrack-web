# == Schema Information
#
# Table name: queued_games
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :bigint
#  game_id    :bigint
#
# Indexes
#
#  index_queued_games_on_account_id  (account_id)
#
FactoryBot.define do
  factory :queued_game do
    game_id     { Faker::Number.number(10) }

    association :account, factory: :account
  end
end
