class Hashtag < ActiveRecord::Base
  has_many :comments, through: :hashtags_comments
  
  include PgSearch
  pg_search_scope :search, against: [:tag],
    using: {tsearch: {dictionary: "english"}},
    ignoring: :accents
    
  def self.search_tags(query)
    if query.present?
      search(query)
      rank = <<-RANK
        ts_rank(to_tsvector(tag), plainto_tsquery(#{sanitize(query)}))
      RANK
      where("to_tsvector('english', tag) @@ plainto_tsquery('english', :q)", q: query)
      .order("#{rank} desc") #order according to rank
      .limit(1) #closest match
    else
      Hashtag.all
    end
  end
end
