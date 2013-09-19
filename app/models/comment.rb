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
    #have all primary comments that contain the :query hashtags
    #filter by some simple popularity metric
    #for now, just return all primary comment results
    #each primary result is a conversation
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
      
      # comments_array = []
      #       comments_array << current_comment.attributes
      #       begin
      #         (0..1).each do |j|
      #             comments_array << current_comment.comments[j] unless current_comment.comments[j].nil?
      #         end
      #         conversation << current_comment.attributes.merge({:comments => comments_array})
      #         current_comment = current_comment.comments.empty? ? nil : current_comment.comments.first
      #       end while(not current_comment.nil?)
      conversations << {:conversation => conversation}
      
    end
    conversations
  end
      #grab the first two secondary results
      #grab the first two tertiary results from first secondary result
      #grab the first two quadernary results from first tertiary result

  
  # def self.search_for_conversations(query)
  #   comments = Comment.search_text(query)
  #   #comments = Comment.search_text(params[:q]) #finds primary comments (where comment_id is nil)
  #   conversations = []
  #   (0..7).each do |i| #each branch
  #     unless comments[i].nil?
  #       #conv_hash = [:comment => {:message => 'whatever', :comments => [:comment => {}, :comment => {}]},:comment => {}]}}
  #       conversation = []
  #       conversation << comments[i] #store primary comment
  #       secondary_comments = [comments[i].comments[0], comments[i].comments[1]] #grab 2 secondary comments
  #       conversation << secondary_comments #store 2 secondary comments in conversation
  #       
  #       tertiary_comments = [] #handle tertiary comments
  #       secondary_comments.each do |sc|
  #         tertiary_comments << sc.comments[0] unless sc.nil? #grab 2 tertiary comments from each secondary comments
  #         tertiary_comments << sc.comments[1] unless sc.nil?
  #       end
  #       conversation << tertiary_comments
  #       
  #       quadernary_comments = [] #handle quadernary comments
  #       tertiary_comments.each do |tc|
  #         quadernary_comments << tc.comments[0] unless tc.nil? #grab 2 quadernary comments from each tertiary comments
  #         quadernary_comments << tc.comments[1] unless tc.nil?
  #       end
  #       conversation << quadernary_comments
  #       
  #       quinary_comments = [] #handle quinary comments
  #       quadernary_comments.each do |qc|
  #         quinary_comments << qc.comments[0] unless qc.nil?
  #       end
  #       conversation << quinary_comments
  #       
  #       senary_comments = [] #handle senary comments
  #       quinary_comments.each do |qc|
  #         senary_comments << qc.comments[0] unless qc.nil?
  #       end
  #       conversation << senary_comments
  #       
  #       septenary_comments = []
  #       senary_comments.each do |sc|
  #         septenary_comments << sc.comments[0] unless sc.nil?
  #       end
  #       conversation << septenary_comments
  #       #(1..6).each do |j| #out from the center
  #         #comment = comment.comments[0]
  #         #conversation << comment
  #       #end
  #       conversations << conversation
  #     end
  #   end
  #   conversations
  # end
  
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