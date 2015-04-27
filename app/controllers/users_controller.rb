class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @status = current_user.friend_statuses()
    @user = current_user
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
  end

  def friends
    
  end

  def status
    
  end
end
