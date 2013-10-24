class ChangeStatusColumnInFriendships < ActiveRecord::Migration
	def up
		remove_column :friendships, :status
		add_column :friendships, :status, :integer
	end

	def down
		remove_column :friendships, :status
		add_column :friendships, :status, :boolean
	end
end
