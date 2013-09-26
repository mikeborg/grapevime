class Comment < ActiveRecord::Base
  belongs_to :comment, :class_name => "Comment", :foreign_key => "comment_id"
  has_many :comments
  has_many :attags_comments
  has_many :hashtags_comments
  has_many :comments_likes
  has_many :comments_closes
  has_many :comments_vimes
  has_many :comments_reports
  has_many :attags, through: :attags_comments
  has_many :hashtags, through: :hashtags_comments
  has_many :likes, through: :comments_likes, source: :user
  has_many :closes, through: :comments_closes, source: :user
  has_many :vimes, through: :comments_vimes, source: :user
  has_many :reports, through: :comments_reports, source: :user
  
  before_save :parse_for_and_associate_tags #expensive method.. consider calling only when self.message is modified.
  before_save :update_popularity
  
  include PgSearch
  pg_search_scope :search, against: [:message],
    using: {tsearch: {dictionary: "english"}},
    #associated_against: {attags: [:tag], hashtags: [:tag]},
    ignoring: :accents
  
  def update_popularity
    like_pop = self.likes.count * 10;
    close_pop = self.closes.count * -2; #negative emphasis = worse than being ignored.
    report_pop = self.reports.count * -100;
    reply_pop = self.comments.count * 30;
    vime_pop = self.vimes.count * 100;
    self.popularity = like_pop + close_pop + report_pop + reply_pop + vime_pop;
  end
  
  def report(user)
    unless CommentsReport.exists?({:comment_id => self.id, :user_id => user.id})
      self.comments_reports.new(:comment_id => self.id, :user_id => user.id)
    else
      puts "This user has already reported this comment."
    end
  end
  
  def unlike(user)
  end
  
  def like(user)
    unless CommentsLike.exists?({:comment_id => self.id, :user_id => user.id})
      self.comments_likes.new(:comment_id => self.id, :user_id => user.id)
    else
      puts "This user has already liked this comment."
    end
  end
  
  def unlike(user)
  end
  
  def vime(user)
    unless CommentsVime.exists?({:comment_id => self.id, :user_id => user.id})
      self.comments_vimes.new(:comment_id => self.id, :user_id => user.id)
    else
      puts "This user has already vimed this comment."
    end
  end
  
  def unvime(user)
  end
  
  def close(user)
    unless CommentsClose.exists?({:comment_id => self.id, :user_id => user.id})
      self.comments_closes.new(:comment_id => self.id, :user_id => user.id)
    else
      puts "This user has already closed this comment."
    end
  end
  
  def unclose(user)
  end
  
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
  def parse_for_and_associate_tags
    # scanned_attags = self.message.scan(/@\S+/)
    #     scanned_attags.each do |tag|
    #       #check for existing association
    #       attag = Attag.find_or_initialize_by_tag(tag[1..-1])
    #       begin
    #         self.attags << attag
    #       rescue ActiveRecord::RecordInvalid => e
    #         # do nothing
    #         #next if(e.message =~ /unique.*constraint.*INDEX_NAME_GOES_HERE/)
    #         #raise
    #       end
    #     end
    
    scanned_hashtags = self.message.scan(/#\S+/).uniq
    scanned_hashtags.each do |tag|
      hashtag = Hashtag.find_or_initialize_by(tag: tag[1..-1]) #remove leading "#"
      if hashtag.new_record?
        self.hashtags.new(tag: tag[1..-1])
      else
        unless HashtagsComment.exists?(hashtag_id: hashtag.id, comment_id: self.id)
          self.hashtags_comments.new(hashtag_id: hashtag.id)
        end
      end
    end
  end
  
end