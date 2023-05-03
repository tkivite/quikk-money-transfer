class ChangeAccountDefaults < ActiveRecord::Migration[7.0]
  def change
    change_column_default :accounts, :currency, from: nil, to: "KES"
    change_column_default :accounts, :balance, from: nil, to: 0.0
  end
end
