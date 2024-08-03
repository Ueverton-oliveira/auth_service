require 'rails_helper'

RSpec.describe Api::AuthController, type: :controller do
  let(:user) { create(:user, password: 'password123') }
  let(:token) { GenerateToken.call(user: user).token }

  describe 'POST #login' do
    it 'logs in with valid credentials' do
      post :login, params: { email: user.email, password: 'password123' }
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('token')
    end

    it 'fails with invalid credentials' do
      post :login, params: { email: user.email, password: 'wrongpassword' }
      expect(response).to have_http_status(:unauthorized)
      expect(response.body).to include('Invalid email or password')
    end
  end

  describe 'GET #validate_token' do
    it 'validates a token' do
      get :validate_token, params: { token: token }
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('user_id')
    end

    it 'fails with an invalid token' do
      get :validate_token, params: { token: 'invalid_token' }
      expect(response).to have_http_status(:unauthorized)
      expect(response.body).to include('Invalid token')
    end
  end
end
