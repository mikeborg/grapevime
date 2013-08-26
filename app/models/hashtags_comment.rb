class HashtagsComment < ActiveRecord::Base
  belongs_to :hashtag
  belongs_to :comment
end
