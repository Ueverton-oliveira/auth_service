FactoryBot.define do
  factory :blacklisted_token do
    token { "MyString" }
    expired_at { "2024-08-03 16:13:31" }
  end
end
