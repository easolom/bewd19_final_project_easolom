class AddPendingToFriendships < ActiveRecord::Migration
  def change
    add_column :friendships, :pending, :boolean, default: true
  end
end
