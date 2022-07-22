# == Schema Information
#
# Table name: accounts
#
#  id         :bigint           not null, primary key
#  email      :string
#  expiration :datetime
#  username   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  session_id :string
#  user_id    :bigint
#
# Indexes
#
#  index_accounts_on_user_id  (user_id)
#
FactoryBot.define do
  factory :account do
    username    { Faker::Internet.user_name }
    session_id  { Faker::Lorem.characters(number: 20) }
    expiration  { Faker::Time.forward(days: 30) }
    email       { Faker::Internet.email }

    association :user, factory: :user
  end
end
