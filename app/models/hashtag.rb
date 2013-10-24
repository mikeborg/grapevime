class Hashtag < ActiveRecord::Base
  has_many :comments, through: :hashtags_comments
  
  include PgSearch
  pg_search_scope :search, against: [:tag],
    using: {tsearch: {dictionary: "english"}},
    ignoring: :accents
    
  def self.search_tags(query)
    query.each_with_index do |tag, index|
      query[index] = tag[1..-1]
    end
    if query.present?
      
      hashtags = Hashtag.where(id: 0)
      query.each do |q|
        search(q)
        # rank = <<-RANK
        #         ts_rank(to_tsvector(tag), plainto_tsquery(#{sanitize(query)}))
        #       RANK
        htags = where("to_tsvector('english', tag) @@ plainto_tsquery('english', :q)", q: q)
        #.order("#{rank} desc") #order according to rank
        htags.each do |htag|
          hashtags << htag
        end
      end
      hashtags
    else
      Hashtag.all
    end
  end
end
