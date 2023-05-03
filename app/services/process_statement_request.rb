# frozen_string_literal: true

class ProcessStatementRequest < ApplicationService
  require 'csv'
  attr_reader :request

  def initialize(request)
    @request = request
    @user = @request.user
  end

  def call
    transactions = Transaction.my_transactions(@user)
    transactions = transactions.where(created_at: @request.start_date.beginning_of_day..@request.end_date.end_of_day)

    CSV.generate(headers: true) do |csv|
      csv << ['ID', 'Sender', 'Receiver', 'Amount', 'Date']
      transactions.each do |transaction|
        csv << [transaction.id, transaction.sender.user.email, transaction.recipient.user.email, transaction.amount,
                transaction.created_at]
      end
    end
  end

end
