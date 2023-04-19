class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications, id: :uuid do |t|
      t.text :message
      t.string :recipient
      t.boolean :scheduled
      t.integer :notification_type
      t.datetime :datetime

      t.timestamps
    end
  end
end
