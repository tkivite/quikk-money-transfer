class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :account_number
      t.string :currency
      t.decimal :balance
      t.integer :status

      t.timestamps
    end
  end
end
