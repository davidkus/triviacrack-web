# frozen_string_literal: true

class Account < ApplicationRecord
  belongs_to :user
  has_many :queued_games, dependent: :destroy

  validates :id, uniqueness: true
end
