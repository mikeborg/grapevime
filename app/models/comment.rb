class Comment < ActiveRecord::Base
  belongs_to :comment
  has_many :comments
  has_many :attags_comments
  has_many :hashtags_comments
  has_many :attags, -> { distinct }, through: :attags_comments
  has_many :hashtags, -> { distinct }, through: :hashtags_comments
  
  before_save :parse_and_associate_tags
  
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
      where(:comment_id => nil).where("to_tsvector('english', message) @@ plainto_tsquery('english', :q)", q: query).order("#{rank} desc").limit(8)  
    else
      scoped
    end
  end
  
  # !!! eventually parse message for tags client-side !!!
  def parse_and_associate_tags
    attags = self.message.scan(/@\S+/)
    attags.each do |tag|
      #check for existing association
      attag = Attag.find_or_initialize_by_tag(tag[1..-1])
      self.attags << attag
    end
    
    hashtags = self.message.scan(/#\S+/)
    hashtags.each do |tag|
      hashtag = Hashtag.find_or_initialize_by_tag(tag[1..-1])
      self.hashtags << hashtag
    end
  end
  
end