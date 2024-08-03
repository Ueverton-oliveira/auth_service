class GenerateToken
  include Interactor

  def call
    if context.user.present?
      context.token = JWT.encode({ user_id: context.user.id }, ENV['SECRET_KEY_BASE'], 'HS256')
    else
      context.fail!(message: 'User must be present')
    end
  end
end
