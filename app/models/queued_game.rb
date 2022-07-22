# frozen_string_literal: true

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
class QueuedGame < ApplicationRecord
  belongs_to :account
end
