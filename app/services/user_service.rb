module UserService

  def self.get_user(account)
    begin
      client = TriviaCrack::API::Client.new

      client.set_session account.session_id, account.id

      client.get_user
    rescue TriviaCrack::Errors::RequestError => e
      return false
    end
  end

end