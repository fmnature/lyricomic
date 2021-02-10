class AddGenreIdToLyrics < ActiveRecord::Migration[6.0]
  def change
    add_column :lyrics, :genre_id, :integer
  end
end
