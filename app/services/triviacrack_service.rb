# frozen_string_literal: true

module TriviaCrackService
  private
    def request(account = nil)
      client = TriviaCrack::API::Client.new

      client.set_session account.session_id, account.id if account

      if block_given?
        yield client
      else
        false
      end
    rescue TriviaCrack::Errors::RequestError => _e
      false
    end
end
