# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  admin                  :boolean          default(FALSE)
#
FactoryBot.define do
  factory :user do
    email       { Faker::Internet.email }
    password    { Faker::Internet.password }

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
