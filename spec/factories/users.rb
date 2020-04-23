FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password_digest { SecureRandom.hex(6) }
  end
end
