require 'rails_helper'

RSpec.describe Api::V1::AuthController, type: :controller do
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

  describe 'POST #register' do
    context 'when valid params are passed' do
      it 'registers a new user' do
        post :register, params: { email: 'user@example.com', password: 'password' }
#         binding.pry
        expect(response).to have_http_status(:created)
        expect(response.body).to include('User created successfully')
        expect(response.body).to include('user@example.com')
        expect(JSON.parse(response.body)['email']).to eq('user@example.com')
      end
    end

    context 'when invalid params are passed' do
      it 'does not register a new user' do
        post :register, params: { email: '', password: 'password' }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('errors')
      end
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
