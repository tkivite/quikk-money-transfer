class Transaction < ApplicationRecord
    self.implicit_order_column = 'created_at'
    enum :status, [:pending, :success, :failed]
    enum :transaction_type, [:topup, :moneytransfer]
    # model associations
    belongs_to  :sender,
                :class_name => "Account",
                :foreign_key  => "sender_id"
    belongs_to  :recipient,
                :class_name => "Account",
                :foreign_key  => "recipient_id"  

    
    before_save :set_default_values

    # Validations
    validates_presence_of :amount, :currency, :sender_id, :recipient_id, :transaction_type
    validates :amount, :numericality => { :greater_than => 0 }
    validates :date_of_transaction, comparison: { less_than: (Time.now).strftime("%Y%m%d%H%M%S%L") }

    
    def validate_transaction_type
        if (self.sender_id == self.recipient_id) && transaction_type  != 0
            self.errors.add(:base, "invalid transaction type")
        end
    end
    def set_default_values
        self.status ||= 0
        self.date_of_transaction ||= DateTime.current
        self.sender_id = (self.sender_id == self.recipient_id)? ENV['HOLDING_ACCT_ID'] : self.sender_id
    end
end
