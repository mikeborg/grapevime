class SearchController < ApplicationController
  #before_action :set_comment, only: [:test]
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
  
  def index
    hashtags = Hashtag.search_tags(params[:q])
    respond_to do |format|
      format.json { render json: Comment.joins(:hashtags).where(comment_id: nil, hashtags: {id: hashtags.first}).to_json(:include => [:comments => {:include => [:comments => {:include => [:comments]}]}]  )}
    end
  end
  
  private
    def set_comment
      @comments = Comment.search_text(search_params[:terms])
    end
    
    def search_params
      params.require(:search).permit(:terms)
    end
end