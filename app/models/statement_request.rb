# frozen_string_literal: true

class StatementRequest < ApplicationRecord
  belongs_to :user
  enum :status, %i[pending success failed]
  self.table_name = "requests"

  before_save :set_default_values
  def set_default_values
    self.status ||= 0
  end

  validates :start_date, :end_date, presence: true
end
