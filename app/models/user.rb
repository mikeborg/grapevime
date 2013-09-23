class User < ActiveRecord::Base
  #has_many :comments_likes
  #has_many :likes, -> { distinct }, through: :comments_likes, source: :user
end
