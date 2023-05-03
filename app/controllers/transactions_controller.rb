# frozen_string_literal: true

class TransactionsController < ApplicationController
  #  Fetch user transactions
  def index
    @my_transactions = Transaction.my_transactions(current_user).joins(:sender).joins(:recipient)
    render json: @my_transactions, status: 200
  end

  # POST /transaction
  def create
    @transaction = Transaction.new(transaction_params)
    if @transaction.save
      # transaction_service to update accts and send alerts
      TransactionManager::FundsTransfer.call(@transaction)
      render json: @transaction, status: :created
    else
      render json: { errors: @transaction.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def dashboard
   incoming_transactions = Transaction.my_incoming(current_user).limit(5)
   outgoing_transactions = Transaction.my_outgoing(current_user).limit(5)
   topup_transactions = Transaction.my_topups(current_user).limit(5)

   render json: { incoming_transactions: incoming_transactions, outgoing_transactions: outgoing_transactions, topup_transactions: topup_transactions},
             status: :ok
    
  end
  private

  def transaction_params
    params.permit(
      :amount, :currency, :date_of_transaction, :sender_id, :recipient_id, :transaction_type, :reference
    )
  end
end
