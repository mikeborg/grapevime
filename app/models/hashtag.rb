class Hashtag < ActiveRecord::Base
  has_many :comments, through: :hashtags_comments
  
end
