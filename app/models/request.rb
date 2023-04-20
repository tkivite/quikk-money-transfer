class Request < ApplicationRecord
    belongs_to :user
    enum :status, [:pending, :success, :failed]
      
    before_save :set_default_values
    def set_default_values
        self.status ||= 0
    end
end
