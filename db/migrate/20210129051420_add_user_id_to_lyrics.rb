class AddUserIdToLyrics < ActiveRecord::Migration[6.0]
  def change
    add_column :lyrics, :user_id, :integer
  end
end
