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
  		friend_hash.store(f.friend_id, f.statuses)
  	end
  	return friend_hash
  end
end
