require 'triviacrack_service'

module LoginService
  extend TriviaCrackService

  def self.perform_login(email, password)
    request { |client| client.login email, password }
  end
end
