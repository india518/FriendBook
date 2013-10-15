class RemoveInvitedAndFriendsFromFriendships < ActiveRecord::Migration
  def up
  	remove_column :friendships, :invited
  	remove_column :friendships, :friends
  	add_column :friendships, :status, :boolean
  end

  def down
  	remove_column :friendships, :status
  	add_column :friendships, :invited, :boolean
  	add_column :friendships, :friends, :boolean
  end
end
