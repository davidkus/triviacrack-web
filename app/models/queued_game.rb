# frozen_string_literal: true

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
class QueuedGame < ApplicationRecord
  belongs_to :account
end
