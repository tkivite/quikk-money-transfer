# frozen_string_literal: true

class ProcessStatementRequest < ApplicationService
  attr_reader :request

  def initialize(request)
    @request = request
    @user = @request.user
  end

  def call
    transactions = Transaction.my_transactions(@user)
    transactions = transactions.where(created_at: @request.start_date.beginning_of_day..@request.end_date.end_of_day)
    byebug
    puts transactions

  end
end
