class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :friendships
  has_many :statuses

  def friend_statuses()
  
  	friend_hash = Hash.new
  	friend_array = friendships
  	friend_array.each do |f|
  		
      friend_name = "#{f.user.first_name} #{f.user.last_name}"
      friend_statuses = f.statuses.collect do | status|
        status.status
      end
      friend_hash.store(friend_name, friend_statueses)
  	end
    user_full_name = "#{first_name} #{last_name}"
    friend_hash.store(user_full_name, statuses)
  	return friend_hash
  end

end
