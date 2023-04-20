class TransactionsController < ApplicationController

  def index
    @my_transactions = Transaction.my_transactions(current_user).joins(:sender).joins(:recipient)
    render json: @my_transactions, status: 200
  end
      # POST /transaction
  def create
    @transaction = Transaction.new(transaction_params)
    if @transaction.save
      # transaction_service to update accts and send alerts
      p @transaction
      TransactionManager::FundsTransfer.call(@transaction)
      render json: @transaction , status: :created
    else
      render json: { errors: @transaction.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def transaction_params
    params.permit(
      :amount,:currency,:date_of_transaction,:sender_id, :recipient_id, :transaction_type,  :reference
    )
  end
end
