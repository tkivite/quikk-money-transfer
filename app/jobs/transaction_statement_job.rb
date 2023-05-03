class TransactionStatementJob < ApplicationJob
  queue_as :default

  def perform(email, data)
    TransactionMailer.send_csv(email, data)
  end
end
