class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions, id: :uuid do |t|
      t.string :currency
      t.decimal :amount
      t.datetime :date_of_transaction
      t.integer :status
      t.string :status_description
      t.string :reference
      t.integer :transaction_type

      t.references :sender, foreign_key: { to_table: 'accounts' }, type: :uuid
      t.references :recipient, foreign_key: { to_table: 'accounts' }, type: :uuid

      t.timestamps
    end
  end
end
