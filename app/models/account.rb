# frozen_string_literal: true

# == Schema Information
#
# Table name: accounts
#
#  id         :bigint           not null, primary key
#  username   :string
#  session_id :string
#  user_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  expiration :datetime
#  email      :string
#
class Account < ApplicationRecord
  belongs_to :user
  has_many :queued_games, dependent: :destroy

  validates :id, uniqueness: true
end
