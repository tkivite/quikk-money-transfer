module TransactionManager
    class FundsTransfer < ApplicationService
        attr_reader :transaction
  
        def initialize(transaction)
            @transaction = transaction
            p @transaction
        end

        def call
            recipient = @transaction.recipient
            sender = @transaction.sender
          
            if @transaction.status == "failed"
                p 'transaction failed validation'
            elsif @transaction.transaction_type == 'fundstransfer' && sender.balance < @transaction.amount
                p 'transaction failed -insufficient balance'
                @transaction.status = 2
                @transaction.status_description = 'insufficient balance'
                @transaction.save!
            else
                recipient_balance = recipient.balance + @transaction.amount
                recipient.balance = recipient_balance
                recipient.save!

                sender_balance = sender.balance - @transaction.amount
                sender.balance = sender_balance
                sender.save!

                @transaction.status = 1
                @transaction.save!
            end    

                TransactionManager::TransactionAlert.call(@transaction)

        end        
    
    end
end