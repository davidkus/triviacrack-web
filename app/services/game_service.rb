module GameService

  def self.get_games(account)
    begin
      client = TriviaCrack::API::Client.new

      client.set_session account.session_id, account.id

      client.get_games
    rescue TriviaCrack::Errors::RequestError => e
      return false
    end
  end

  def self.new_game(account)
    begin
      client = TriviaCrack::API::Client.new

      client.set_session account.session_id, account.id

      client.start_new_game
    rescue TriviaCrack::Errors::RequestError => e
      return false
    end
  end

end