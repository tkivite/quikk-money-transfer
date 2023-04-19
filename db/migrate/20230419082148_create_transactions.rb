class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions, id: :uuid do |t|
      t.string :currency
      t.decimal :amount
      t.datetime :date_of_transaction
      t.integer :status

      t.references :sender
      t.references :recipient

      t.timestamps
    end
    add_foreign_key :notifications, :users, column: :sender_id, primary_key: :id
    add_foreign_key :notifications, :users, column: :recipient_id, primary_key: :id
  end
end
