require 'jwt'

module AuthenticationHelper
  def authenticate(user)
    payload = { user_id: user.id }
    JWT.encode(payload, ENV['JWT_TOKEN_KEY'])
  end
end
