# frozen_string_literal: true

class Account < ApplicationRecord
  belongs_to :user
  enum :status, %i[pending active inactive]
end
