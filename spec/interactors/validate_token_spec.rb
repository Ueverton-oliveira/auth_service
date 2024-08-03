require 'rails_helper'

RSpec.describe Api::AuthController, type: :controller do
  let(:user) { create(:user, email: 'test@example.com', password: 'password') }
  let(:token) do
    result = GenerateToken.call(user: user)
    result.token if result.success?
  end

  describe 'POST #register' do
    it 'registers a new user' do
      post :register, params: { user: { email: 'new@example.com', password: 'password' } }
      expect(response).to have_http_status(:created)
      expect(response.body).to include('User created successfully')
      expect(User.find_by(email: 'new@example.com')).to be_present
    end
  end

  describe 'POST #login' do
    it 'logs in with valid credentials' do
      post :login, params: { email: user.email, password: 'password' }
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
    context 'with a valid token' do
      it 'validates a token' do
        context = ValidateToken.call(token: token)
        expect(context).to be_success
        expect(context.user).to eq(user)
      end
    end

    context 'with an invalid token' do
      let(:invalid_token) { 'invalid_token' }

      it 'fails to validate an invalid token' do
        context = ValidateToken.call(token: invalid_token)
        expect(context).to be_failure
        expect(context.message).to eq('Invalid token')
      end
    end
  end
end
