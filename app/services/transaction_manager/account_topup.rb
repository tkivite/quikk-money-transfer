module TransactionManager
    class AccountTopup < ApplicationService
        attr_reader :transaction
  
        def initialize(transaction)
            @transaction = transaction
            # @transaction
        end

        def call
            account = @transaction.recipient
            balance = account.balance + @transaction.amount
            account.balance = balance
            account.save!
        end
    
    end
end