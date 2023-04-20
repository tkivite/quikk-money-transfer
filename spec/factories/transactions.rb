
# spec/factories/transactions.rb

FactoryBot.define do
  factory :transaction do
    amount { 100 }
    currency { 'KES' }
    date_of_transaction { Time.zone.now }
    sender { create(:account) }
    recipient { create(:account) }
    transaction_type { 'fundstransfer' }
    reference { Faker::Alphanumeric.alphanumeric(number: 10) }
  end
end
