class CreateRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :requests, id: :uuid do |t|
      t.integer :request_type
      t.datetime :start_date
      t.datetime :end_date
      t.integer :status
      t.references :users, null: false, foreign_key: true

      t.timestamps
    end
  end
end
