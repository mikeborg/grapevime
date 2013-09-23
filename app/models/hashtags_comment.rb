class HashtagsComment < ActiveRecord::Base
  belongs_to :hashtag
  belongs_to :comment
  validates :hashtag_id, :uniqueness => { :scope => :comment_id }
end