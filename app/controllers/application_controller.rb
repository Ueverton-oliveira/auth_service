class ApplicationController < ActionController::API
  before_action :authenticate_user!

  private

  def authenticate_user!
    unless current_user
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def current_user
    # Here you would decode the token and find the user
    token = request.headers['Authorization']&.split(' ')&.last
    return unless token

    decoded_token = AuthenticationService.decode_token(token)
    return unless decoded_token

    @current_user ||= User.find_by(id: decoded_token['user_id'])
  end
end
