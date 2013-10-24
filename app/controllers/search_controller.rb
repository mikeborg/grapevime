class SearchController < ApplicationController
  #before_action :set_comment, only: [:test]
  protect_from_forgery except: [:create]
  
  require 'json'
  def test
    #conversations = Comment.search_for_conversations(params[:q])
     comments = Comment.search_text(params[:q]) #finds primary comments (where comment_id is nil)
         conversations = []
         (0..7).each do |i| #each branch
           unless comments[i].nil?
             conversation = []
             conversation << comments[i] #store primary comment
             secondary_comments = [comments[i].comments[0], comments[i].comments[1]] #grab 2 secondary comments
             conversation << secondary_comments #store 2 secondary comments in conversation
             
             tertiary_comments = [] #handle tertiary comments
             secondary_comments.each do |sc|
               tertiary_comments << sc.comments[0] #grab 2 tertiary comments from each secondary comments
               tertiary_comments << sc.comments[1]
             end
             conversation << tertiary_comments
             
             quadernary_comments = [] #handle quadernary comments
             tertiary_comments.each do |tc|
               quadernary_comments << tc.comments[0] #grab 2 quadernary comments from each tertiary comments
               quadernary_comments << tc.comments[1]
             end
             conversation << quadernary_comments
             
             quinary_comments = [] #handle quinary comments
             quadernary_comments.each do |qc|
               quinary_comments << qc.comments[0] unless qc.nil?
             end
             conversation << quinary_comments
             
             senary_comments = [] #handle senary comments
             quinary_comments.each do |qc|
               senary_comments << qc.comments[0] unless qc.nil?
             end
             conversation << senary_comments
             
             septenary_comments = []
             senary_comments.each do |sc|
               septenary_comments << sc.comments[0] unless sc.nil?
             end
             conversation << septenary_comments
             #(1..6).each do |j| #out from the center
               #comment = comment.comments[0]
               #conversation << comment
               
             #end
             conversations << conversation
           end
         end
         conversations
    
    respond_to do |format|
      
      format.json { render :json => { :conversations => conversations } }
    end
  end
  
  def create
    @search = Search.new(search_params)
    respond_to do |format|
      if @search.save
        tweets = current_user.twitter.search(search_params[:q])
        tweets.statuses.each do |tweet|
          Comment.create!(sm_type: 'twitter',
                          sm_screen_name: tweet.user.screen_name,
                          sm_user_id: tweet.user.id,
                          sm_status_id: tweet.id,
                          source_data: tweet.to_s,
                          tw_retweet_count: tweet.retweet_count,
                          tw_favorite_count: tweet.favorite_count,
                          tw_user_followers_count: tweet.user.followers_count,
                          tw_user_favorites_count: tweet.user.favorites_count,
                          tw_user_statuses_count: tweet.user.statuses_count,
                          message: tweet.text
                          )
        end
        @search.results = Comment.search_messages(search_params[:q])
        format.json { render json: @search.to_json(:include => :conversations) }#Comment.joins(:hashtags).where(comment_id: nil, hashtags: { id: hashtags } ).to_json } #:include => [:comments => {:include => [:comments => {:include => [:comments]}]}]  )}
      else
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
    def set_comment
      @comments = Comment.search_text(search_params[:terms])
    end
    
    def search_params
      params.require(:search).permit(:q)
    end
end