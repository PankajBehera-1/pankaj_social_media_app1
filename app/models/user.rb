class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # validates :username, presence: true
  has_many :posts
  has_many :comments

  has_many :likes
  has_many :liked_posts, -> { where(reaction: 'like') }, through: :likes, source: :post

#friendship 
  has_many :friendships, dependent: :destroy
  has_many :followers, through: :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id', dependent: :destroy
  has_many :following, through: :inverse_friendships, source: :friend 
  has_one_attached :avatar
  mount_uploader :avatar, AvatarUploader
  def follow(user)
    friendships.create(friend: user)
  end

  def unfollow(user)
    friendships.find_by(friend: user).destroy
  end

  def following?(user)
    following.include?(user)
  end
end


