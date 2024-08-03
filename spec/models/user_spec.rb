require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(6).on(:create) }
  end

  context 'password encryption' do
    it 'does not store the password in plaintext' do
      user = User.create!(email: 'user@example.com', password: 'password123')
      expect(user.password_digest).not_to eq('password123')
    end
  end

  context 'authentication' do
    let(:user) { User.create!(email: 'user@example.com', password: 'password123') }

    it 'authenticates with a correct password' do
      expect(user.authenticate('password123')).to eq(user)
    end

    it 'does not authenticate with an incorrect password' do
      expect(user.authenticate('wrongpassword')).to be_falsey
    end
  end
end
