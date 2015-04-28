class Account < ActiveRecord::Base
  belongs_to :user
  has_many :queued_games

  validates :email, presence: true, uniqueness: true
end
