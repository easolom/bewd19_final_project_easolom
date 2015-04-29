class FriendshipsController < ApplicationController
	before_action :authenticate_user!

	def create
		@new_friend = Friendship.create( user_id: current_user.id,
      		friend_id: params[:friendship][:friend_id])
     	redirect_to root_path
	end

	def destroy
	    friendship_object = Friendship.find(params[:id])
	    friendship_object.destroy
    	redirect_to root_path
	end

	def update
		#update database to show friend request is accepted
    @friend = Friendship.find(params[:id])
    @friend.update(accepted: true,
      pending: false)
    user_id = @friend.user_id
    friend_id = @friend.friend_id
    Friendship.create(user_id: friend_id,
    	friend_id: user_id,
    	accepted: true,
    	pending: false)
    redirect_to user_path(@friend.friend_id)
    #add row in database reflecting that they are your friend also
    # @friend_to_current = Friendship.new(user_id: current_user.id, 
    #   friend_id: @friend.user_id,
    #   accepted: true,
    #   pending: false)
    # @friend_to_current.save
    # redirect_to users_friend_requests_path

    # @friend = Friendship.find(params[:friendship_id])
    # @friend.update(pending: false)
    # redirect_to users_friend_requests_path
	end

	def index
		@friendships = Friendship.where(friend_id: current_user.id, pending: true)

	end
end