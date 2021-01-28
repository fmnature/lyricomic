class CreateLyrics < ActiveRecord::Migration[6.0]
  def change
    create_table :lyrics do |t|
      t.string  :word,    null: false
      t.text    :text

      t.timestamps
    end
  end
end
