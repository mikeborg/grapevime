class Comment < ActiveRecord::Base
  belongs_to :comment, :class_name => "Comment", :foreign_key => "comment_id"
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
  
  def self.search_comments(query)
    hashtags = Hashtag.search_tags(query) #search for hashtags similar to :query
    comment_results = []
    hashtags.each do |hashtag|
      comment_results.concat(Comment.joins(:hashtags).where(comment_id: nil, hashtags: {id: hashtag.id}))
    end
    comment_results = comment_results.uniq
    conversations = []
    
    comment_results.each do |cr|
      current_comment = cr
      conversation = []
      conversation << [current_comment.attributes]
      current_comment = current_comment.comments.empty? ? nil : current_comment.comments[0]
      begin
        arr = []
        arr << current_comment.attributes
        arr << current_comment.comment.comments[1] unless current_comment.comment.comments[1].nil?
        conversation << arr #.merge(:comments => current_comment.comments[1])
        current_comment = current_comment.comments.empty? ? nil : current_comment.comments.first
      end while(not current_comment.nil?)
      conversations << {:conversation => conversation}
      
    end
    conversations
  end
  
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
      hashtag = Hashtag.find_or_initialize_by(tag: tag[1..-1])
      self.hashtags << hashtag
    end
  end
  
end