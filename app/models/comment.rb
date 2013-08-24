class Comment < ActiveRecord::Base
  serialize :content, JSON
end