# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  enum :status, %i[pending active inactive]
  before_save :set_default_values
  after_create :create_user_account
  # Associations
  has_one :account, dependent: :destroy
  has_many :sender_transactions, through: :account
  has_many :requests
  # Validations
  validates_presence_of :surname, :othernames, :email, :mobile, :password_digest
  validates_uniqueness_of :email, :mobile
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  def set_default_values
    self.status ||= :active
  end
  def create_user_account
    Account.create(
      account_number: self.surname,
      user_id: self.id,
      status: 1
    )
  end
end
