class CreatesLikesTable < ActiveRecord::Migration
  def change
    add_column :likes, :guestbook_entry_id, :integer
    add_column :likes, :num_likes, :integer, default: 0
  end
end
