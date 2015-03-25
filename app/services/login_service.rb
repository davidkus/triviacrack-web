module LoginService

  def self.perform_login(email, password)
    begin
      client = TriviaCrack::API::Client.new

      client.login email, password
    rescue TriviaCrack::Errors::RequestError => e
      return false
    end
  end

end