# frozen_string_literal: true

require "trivia_crack_service"

module UserService
  extend TriviaCrackService

  def self.get_user(account)
    request(account, &:get_user)
  end
end
