class Friendship < ActiveRecord::Base
	belongs_to :user

	def self.is_friend?(id)
		
		if (Friendship.where(friend_id: id, user_id: current_user.id))
			return true
		else
			return false
		end
	end
end
