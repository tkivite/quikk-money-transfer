class RemoveCurrencyFromTransactions < ActiveRecord::Migration[7.0]
  def change
    remove_column :transactions, :currency, :string
  end
end
