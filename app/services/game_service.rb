# frozen_string_literal: true

require "trivia_crack_service"

module GameService
  extend TriviaCrackService

  def self.get_games(account)
    request(account, &:get_games)
  end

  def self.new_game(account)
    request(account, &:start_new_game)
  end
end
