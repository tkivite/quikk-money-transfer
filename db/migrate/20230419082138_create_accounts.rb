class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts, id: :uuid do |t|
      t.string :account_number
      t.string :currency
      t.decimal :balance
      t.integer :status
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.timestamps
    end
  end
end
