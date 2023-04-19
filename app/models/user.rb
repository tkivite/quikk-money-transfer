class User < ApplicationRecord
    has_secure_password

    enum :status, [:pending, :active, :inactive]
    before_save :set_default_values
    # Associations
    # Validations
    validates_presence_of(:surname,:othernames,:email,:mobile,:password_digest)
    validates_uniqueness_of( :email,:mobile)
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  def set_default_values
   
    self.status ||= :pending
  end
end
