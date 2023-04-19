class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :surname
      t.string :othernames
      t.string :email
      t.string :mobile
      t.string :password_digest
      t.integer :status

      t.timestamps
    end
  end
end
