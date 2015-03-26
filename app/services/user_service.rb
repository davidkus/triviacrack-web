require 'triviacrack_service'

module UserService
  extend TriviaCrackService

  def self.get_user(account)
    request(account) { |client| client.get_user }
  end
end
