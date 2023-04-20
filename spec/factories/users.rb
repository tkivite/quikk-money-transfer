# spec/factories/users.rb

FactoryBot.define do
  factory :user do
    surname { Faker::Name.last_name }
    othernames { Faker::Name.first_name }
    email { Faker::Internet.email }
    mobile { Faker::PhoneNumber.cell_phone }
    password { Faker::Internet.password }
    password_confirmation { password }
  end
end

# spec/factories/accounts.rb

FactoryBot.define do
  factory :account do
    account_number { Faker::Number.number(digits: 10) }
    user
    currency { 'KES' }
    balance { 0.00 }
    status { 1 }
  end
end
