class Account < ApplicationRecord
    belongs_to :user
    enum :status, [:pending, :active, :inactive]
end
