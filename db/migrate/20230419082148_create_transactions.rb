class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :currency
      t.decimal :amount
      t.datetime :date_of_transaction
      t.integer :status

      t.timestamps
    end
  end
end
