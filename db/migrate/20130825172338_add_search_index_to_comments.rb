class AddSearchIndexToComments < ActiveRecord::Migration
  def up
    execute "create index comments_message on comments using gin(to_tsvector('english', message))"
    execute "create index attags_tag on attags using gin(to_tsvector('english', tag))"
    execute "create index hashtags_tag on hashtags using gin(to_tsvector('english', tag))"
  end

  def down
    execute "drop index comments_message"
    execute "drop index atttags_tag"
    execute "drop index hashtags_tag"
  end
end