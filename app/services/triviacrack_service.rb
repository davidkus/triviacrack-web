module TriviaCrackService

  private

  def request(account = nil)
    begin
      client = TriviaCrack::API::Client.new

      if account
        client.set_session account.session_id, account.id
      end

      if block_given?
        yield client
      else
        return false
      end
    rescue TriviaCrack::Errors::RequestError => e
      return false
    end
  end
end
