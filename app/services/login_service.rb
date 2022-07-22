# frozen_string_literal: true

require "trivia_crack_service"

module LoginService
  extend TriviaCrackService

  def self.perform_login(email, password)
    request { |client| client.login email, password }
  end
end
