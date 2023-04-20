module TransactionManager
    class FundsTransfer < ApplicationService
        attr_reader :transaction
  
        def initialize(transaction)
            @transaction = transaction
            # @transaction
        end

        def call
            recipient = @transaction.recipient
            sender = @transaction.sender
            recipient_balance = recipient.balance + @transaction.amount
            recipient.balance = recipient_balance
            recipient.save!

            sender_balance = sender.balance - @transaction.amount
            sender.balance = sender_balance
            sender.save!
            
            @transaction.status = 1
            @transaction.save!
        end
    
    end
end