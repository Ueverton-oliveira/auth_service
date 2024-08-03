class ValidateToken
  include Interactor

  def call
    decoded_token = AuthenticationService.decode_token(context.token)
    if decoded_token
      user_id = decoded_token['user_id']
      user = User.find_by(id: user_id)
      if user
        context.user = user
      else
        context.fail!(message: 'Invalid token')
      end
    else
      context.fail!(message: 'Invalid token')
    end
  end
end
