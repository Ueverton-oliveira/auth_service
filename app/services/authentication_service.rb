require 'jwt'

class AuthenticationService
  attr_reader :email, :password

  def initialize(email, password)
    @email = email
    @password = password
  end

  def authenticate
    user = User.find_by(email: email)
    return nil unless user&.authenticate(password)

    # Usando o interactor para gerar o token
    result = GenerateToken.call(user: user)
    result.token if result.success?
  end

  def self.decode_token(token)
    JWT.decode(token, ENV['SECRET_KEY_BASE'], true, algorithm: 'HS256')[0]
  rescue JWT::DecodeError
    nil
  end
end
