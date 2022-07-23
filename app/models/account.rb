# frozen_string_literal: true

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
class Account < ApplicationRecord
  belongs_to :user
  has_many :queued_games, dependent: :destroy

  validates :id, uniqueness: true

  encrypts :session_id
end
