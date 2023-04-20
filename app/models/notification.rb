# frozen_string_literal: true

class Notification < ApplicationRecord
  enum :notification_type, %i[sms email]
  enum :status, %i[pending sent failed]
  before_save :set_default_values

  # model association

  # validations
  validates_presence_of :recipient, :notification_type

  def set_default_values
    self.message ||= 'Congratulations, your transaction is successful.'
    self.status ||= :pending
    self.scheduled ||= false
    self.datetime ||= DateTime.current
  end
end
