class Account < ActiveRecord::Base
  belongs_to :user
  has_many :queued_games

  validates :id, uniqueness: true
end
