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
    @friend_on_page = User.find(params[:id])
    @new_friend = Friendship.create( user_id: current_user.id,
      friend_id: :friend_id)
    redirect_to @friend_on_page
  end

  def friends_remove
    @friend_on_page = User.find(params[:id])
    friendship_object = Friendship.where(user_id: current_user.id, friend_id: params[:id])
    Friendship.destroy(friendship_object.id)
    redirect_to @friend_on_page
  end

  def status
    @new_status = Status.new(status: params[:status_entered],
      user_id: current_user.id)
    @new_status.save
    if @new_status.save
      render "index"
    
  end

  def search
    @list = User.where('first_name LIKE :search OR last_name LIKE :search', search: "%#{params[:q]}%")
  end
end
