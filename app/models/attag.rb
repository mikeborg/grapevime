class Attag < ActiveRecord::Base
  has_many :comments, :through => :attags_comments
end
