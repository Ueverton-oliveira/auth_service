require 'rails_helper'

RSpec.describe GenerateToken, type: :interactor do
  let(:user) { create(:user, password: 'password123') }

  it 'generates a token' do
    context = GenerateToken.call(user: user)
    expect(context).to be_success
    expect(context.token).to be_present
  end

  it 'fails if no user is provided' do
    context = GenerateToken.call(user: nil)
    expect(context).to be_failure
    expect(context.message).to eq('User must be present')
  end
end
