class TransactionsController < ApplicationController

      # POST /transaction
  def create
    @transaction= Transaction.new(transaction_params)
    if @transaction.save
      # transaction_service to update accts and send alerts

      @transaction.transaction_type == "topup" ? TransactionManager::AccountTopup.call(@transaction) : TransactionManager::FundsTransfer.call(@transaction)
      render json: @transaction , status: :created
    else
      render json: { errors: @transaction.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def transaction_params
    params.permit(
      :amount,:currency,:date_of_transaction,:sender_id, :recipient_id, :transaction_type
    )
  end
end
