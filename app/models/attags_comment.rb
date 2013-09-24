class AttagsComment < ActiveRecord::Base
  belongs_to :attag
  belongs_to :comment
  validates :hashtag_id, :uniqueness => { :scope => :comment_id }
end
