class Comment < ActiveRecord::Base
  belongs_to :comment
  has_many :comments
  has_many :attags_comments
  has_many :hashtags_comments
  has_many :attags, :through => :attags_comments
  has_many :hashtags, :through => :hashtags_comments
  
  include PgSearch
  pg_search_scope :search, against: [:message],
    using: {tsearch: {dictionary: "english"}},
    #associated_against: {attags: [:tag], hashtags: [:tag]},
    ignoring: :accents
  
  def self.search_text(query)
    if query.present?
      search(query)
      rank = <<-RANK
        ts_rank(to_tsvector(message), plainto_tsquery(#{sanitize(query)}))
      RANK
      #ts_rank(to_tsvector(attags.tag), plainto_tsquery(#{sanitize(query)})) +
      #ts_rank(to_tsvector(hashtags.tag), plainto_tsquery(#{sanitize(query)}))
      where("to_tsvector('english', message) @@ plainto_tsquery('english', :q)", q: query).order("#{rank} desc")  
    else
      scoped
    end
  end
  
end