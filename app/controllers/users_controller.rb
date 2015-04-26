class UsersController < ApplicationController
  before_action :authenicate_user!

  $current_user = User.find(session[:user_id])
  def index
  	@user = $current_user
    @statuses = $current_user.statuses
  end

  def new
  	
  end

  def create
  	
  	
  end

  def show
    @user = User.find(params[:id])
    @statuses = @user.statuses
  end

  def edit
  end

  def friends
    @friends = $current_user.friendships
  end

  def status
    @status = $current_user.friend_statuses()
  end
end
