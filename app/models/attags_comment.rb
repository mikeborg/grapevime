class AttagsComment < ActiveRecord::Base
  belongs_to :attag
  belongs_to :comment
end
