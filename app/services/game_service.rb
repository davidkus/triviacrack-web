require 'triviacrack_service'

module GameService
  extend TriviaCrackService

  def self.get_games(account)
    request(account) { |client| client.get_games }
  end

  def self.new_game(account)
    request(account) { |client| client.start_new_game }
  end
end
