# frozen_string_literal: true

require "triviacrack_service"

module UserService
  extend TriviaCrackService

  def self.get_user(account)
    request(account, &:get_user)
  end
end
