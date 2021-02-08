class CreateTaggings < ActiveRecord::Migration[6.0]
  def change
    create_table :taggings do |t|
      t.references :lyric, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
  end
end
