class CreateRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :requests, id: :uuid do |t|
      t.integer :request_type
      t.datetime :start_date
      t.datetime :end_date
      t.integer :status
      t.references :user, null: false, foreign_key: true,type: :uuid

      t.timestamps
    end
  end
end
