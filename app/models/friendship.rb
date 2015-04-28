class Friendship < ActiveRecord::Base
	belongs_to :user

	def is_friend?(id)
		
		if (Friendship.user_id == current_user.id && friend_id == )
	end
end
