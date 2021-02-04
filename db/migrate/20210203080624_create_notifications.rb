class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.integer :sender_id
      t.integer :sended_id
      t.integer :lyric_id
      t.integer :comment_id
      t.string  :action
      t.boolean :checked, default: false, null: false

      t.timestamps
    end
  end
end
