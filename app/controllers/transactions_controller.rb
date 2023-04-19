class TransactionsController < ApplicationController

      # POST /transaction
  def create
    @transaction= Transaction.new(transaction_params)
    if @transaction.save
    #   send alert
      render json: { user: @transaction, account: account }, status: :created
    else
      render json: { errors: @transaction.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def transaction_params
    params.permit(
      :amount,:currency,:date_of_transaction,:sender_id, :recipient_id
    )
  end
end
