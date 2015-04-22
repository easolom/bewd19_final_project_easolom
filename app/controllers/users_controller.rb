class UsersController < ApplicationController
  before_action :authenicate_user!

  $current_user = User.find(session[:user_id])
  def index
  	@user = $current_user
    @statuses = $current_user.statuses
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new
  	
  end

  def show
  end

  def edit
  end

  def friends
  end

  def status
    @status = $current_user.friend_statuses($current_user)
  end
end
