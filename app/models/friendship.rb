class Friendship < ActiveRecord::Base
	belongs_to :user

	# def self.is_friend?(user_id, friend_id)
	# 	return Friendship.exists?(friend_id: friend_id, user_id: user_id)
	# end

end
