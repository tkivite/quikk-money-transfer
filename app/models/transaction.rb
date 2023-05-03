# frozen_string_literal: true

class Transaction < ApplicationRecord
  # scope :sent_transactions, ->(current_user) { where sender_id: current_user.account.id }
  scope :my_transactions, lambda { |current_user|
                            where(['recipient_id = ? or sender_id = ? ', current_user.account.id.to_s, current_user.account.id.to_s])
                          }

  enum :status, %i[pending success failed]
  enum :transaction_type, %i[topup fundstransfer]
  # model associations
  belongs_to  :sender,
              class_name: 'Account',
              foreign_key: 'sender_id'
  belongs_to  :recipient,
              class_name: 'Account',
              foreign_key: 'recipient_id'

  before_save :validate_transaction_type, :validate_currency, :set_default_values, :check_user
  after_create :update_balances
  # after_save :check_user

  # Validations
  validates_presence_of :amount, :sender_id, :recipient_id, :transaction_type
  validates :amount, numericality: { greater_than: 0 }
  validates :date_of_transaction, comparison: { less_than: Time.now.strftime('%Y%m%d%H%M%S%L') }

  def validate_transaction_type
    return unless (sender_id == recipient_id) && transaction_type != 0

    errors.add(:base, 'invalid transaction type')
  end

  def validate_currency
    return if sender.currency == recipient.currency

    errors.add(:base, 'different account currency')
  end

  def check_user
    return unless sender.status != 'active' || sender.user.status != 'active'

    self.status = 2
    self.status_description = 'User or Account is inactive'
  end

  def set_default_values
    self.status ||= 0
    self.date_of_transaction ||= DateTime.current
    self.sender_id = sender_id == recipient_id ? ENV['HOLDING_ACCT_ID'] : sender_id
  end

  def update_balances
    TransactionManager::FundsTransfer.call(self)
  end
end
