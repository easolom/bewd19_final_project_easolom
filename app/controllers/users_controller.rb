class UsersController < ApplicationController
  before_action :authenticate_user!

  def index

    @status = current_user.friend_statuses()
    @user = current_user
    @new_status = Status.new
  end

  def new
  end

  def create
  end

  def show
    @user = User.find(params[:id])
    @statuses = @user.statuses
    @friends = @user.friendships.where(accepted: 'true')
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(first_name: params[:user][:first_name],
      last_name: params[:user][:last_name],
      birthday: params[:user][:birthday],
      location: params[:user][:location],
      email: params[:user][:email])

    redirect_to @user
  end

  def friends_add
    @friend_on_page = User.find(params[:friend_id])
    @new_friend = Friendship.create( user_id: current_user.id,
      friend_id: params[:friend_id])
    redirect_to @friend_on_page
  end

  def friends_remove
    @friend_on_page = User.find(params[:friend_id])
    friendship_object = Friendship.where(user_id: current_user.id, friend_id: params[:friend_id])
    Friendship.destroy(friendship_object.id)
    redirect_to @friend_on_page
  end

  def status
    @new_status = Status.new(status: params[:status_entered],
      user_id: current_user.id)
    @new_status.save
    if @new_status.save
      redirect_to root_path
    end
  end

  def search
    @list = User.where('first_name LIKE :search OR last_name LIKE :search', search: "%#{params[:search]}%")
  end

  def friend_requests
    @friend_requests = Friendship.where(friend_id: current_user.id, accepted: false, pending: true)
  end

  def accept_friend_request
    #update database to show friend request is accepted
    @friend = Friendship.find(params[:friendship_id])
    @friend.update(accepted: true,
      pending: false)
    #add row in database reflecting that they are your friend also
    @friend_to_current = Friendship.new(user_id: current_user.id, 
      friend_id: @friend.user_id,
      accepted: true,
      pending: false)
    @friend_to_current.save
    redirect_to users_friend_requests_path
  end

  def reject_friend_request
    @friend = Friendship.find(params[:friendship_id])
    @friend.update(pending: false)
    redirect_to users_friend_requests_path

  end
end
