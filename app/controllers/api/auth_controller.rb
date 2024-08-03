class Api::AuthController < ApplicationController
  skip_before_action :authenticate_user!, only: [:register, :login, :validate_token]

  def register
    user = User.new(user_params)
    if user.save
      render json: { message: 'User created successfully', user: user }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    service = AuthenticationService.new(params[:email], params[:password])
    token = service.authenticate

    if token
      render json: { token: token }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def validate_token
    result = ValidateToken.call(token: params[:token])

    if result.success?
      render json: { user_id: result.user.id }, status: :ok
    else
      render json: { error: result.message }, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
