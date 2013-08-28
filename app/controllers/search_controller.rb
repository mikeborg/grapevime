class SearchController < ApplicationController
  #before_action :set_comment, only: [:test]
  
  def test
    comments = Comment.search_text("#NBAFinals")
    conversations = []
    (0..5).each do |i| #around the circle
      unless comments[i].nil?
        conversation = []
        conversation << comments[i]
      
        comment = comments[i].comments[0]
        conversation << comment
        (1..6).each do |j| #out from the center
          comment = comment.comments[0]
          conversation << comment
        end
        conversations << conversation
      end
    end
    conversations
    
    respond_to do |format|
      
      format.json { render :json => { :conversations => conversations } }
    end
      
  end
  
  def index
    
    respond_to do |format|
      conversations = []
      conversation = []
      #layer 1
      conversation << { :id => 1, :comment_id => nil, :sm_type => Random.rand(3) ,:content => "This is comment-layer 1. (ID: 1)" }
      conversation << { :id => 2, :comment_id => nil, :sm_type => Random.rand(3) ,:content => "This is comment-layer 1. (ID: 2)" }
      conversation << { :id => 3, :comment_id => nil, :sm_type => Random.rand(3) ,:content => "This is comment-layer 1. (ID: 3)" }
      #layer 2
      #1
      conversation << { :id => 4, :comment_id => 1, :sm_type => Random.rand(3) ,:content => "This is comment-layer 2. (ID: 4)" }
      conversation << { :id => 5, :comment_id => 1, :sm_type => Random.rand(3) ,:content => "This is comment-layer 2. (ID: 5)" }
      conversation << { :id => 6, :comment_id => 1, :sm_type => Random.rand(3) ,:content => "This is comment-layer 2. (ID: 6)" }
      #2
      conversation << { :id => 7, :comment_id => 2, :sm_type => Random.rand(3) ,:content => "This is comment-layer 2. (ID: 7)" }
      conversation << { :id => 8, :comment_id => 2, :sm_type => Random.rand(3) ,:content => "This is comment-layer 2. (ID: 8)" }
      conversation << { :id => 9, :comment_id => 2, :sm_type => Random.rand(3) ,:content => "This is comment-layer 2. (ID: 9)" }
      #3
      conversation << { :id => 10, :comment_id => 3, :sm_type => Random.rand(3) ,:content => "This is comment-layer 2. (ID: 10)" }
      conversation << { :id => 11, :comment_id => 3, :sm_type => Random.rand(3) ,:content => "This is comment-layer 2. (ID: 11)" }
      conversation << { :id => 12, :comment_id => 3, :sm_type => Random.rand(3) ,:content => "This is comment-layer 2. (ID: 12)" }
      #layer 3
      #4
      conversation << { :id => 13, :comment_id => 4, :sm_type => Random.rand(3) ,:content => "This is comment-layer 3. (ID: 13)" }
      conversation << { :id => 14, :comment_id => 4, :sm_type => Random.rand(3) ,:content => "This is comment-layer 3. (ID: 14)" }
      conversation << { :id => 15, :comment_id => 4, :sm_type => Random.rand(3) ,:content => "This is comment-layer 3. (ID: 15)" }
      #5
      conversation << { :id => 16, :comment_id => 5, :sm_type => Random.rand(3) ,:content => "This is comment-layer 3. (ID: 16)" }
      conversation << { :id => 17, :comment_id => 5, :sm_type => Random.rand(3) ,:content => "This is comment-layer 3. (ID: 17)" }
      conversation << { :id => 18, :comment_id => 5, :sm_type => Random.rand(3) ,:content => "This is comment-layer 3. (ID: 18)" }
      #6
      conversation << { :id => 19, :comment_id => 6, :sm_type => Random.rand(3) ,:content => "This is comment-layer 3. (ID: 19)" }
      conversation << { :id => 20, :comment_id => 6, :sm_type => Random.rand(3) ,:content => "This is comment-layer 3. (ID: 20)" }
      conversation << { :id => 21, :comment_id => 6, :sm_type => Random.rand(3) ,:content => "This is comment-layer 3. (ID: 21)" }
      #7
      conversation << { :id => 22, :comment_id => 7, :sm_type => Random.rand(3) ,:content => "This is comment-layer 3. (ID: 22)" }
      conversation << { :id => 23, :comment_id => 7, :sm_type => Random.rand(3) ,:content => "This is comment-layer 3. (ID: 23)" }
      conversation << { :id => 24, :comment_id => 7, :sm_type => Random.rand(3) ,:content => "This is comment-layer 3. (ID: 24)" }
      #8
      conversation << { :id => 25, :comment_id => 8, :sm_type => Random.rand(3) ,:content => "This is comment-layer 3. (ID: 25)" }
      conversation << { :id => 26, :comment_id => 8, :sm_type => Random.rand(3) ,:content => "This is comment-layer 3. (ID: 26)" }
      conversation << { :id => 27, :comment_id => 8, :sm_type => Random.rand(3) ,:content => "This is comment-layer 3. (ID: 27)" }
      #9
      conversation << { :id => 28, :comment_id => 9, :sm_type => Random.rand(3) ,:content => "This is comment-layer 3. (ID: 28)" }
      conversation << { :id => 29, :comment_id => 9, :sm_type => Random.rand(3) ,:content => "This is comment-layer 3. (ID: 29)" }
      conversation << { :id => 30, :comment_id => 9, :sm_type => Random.rand(3) ,:content => "This is comment-layer 3. (ID: 30)" }
      #10
      conversation << { :id => 31, :comment_id => 10, :sm_type => Random.rand(3) ,:content => "This is comment-layer 3. (ID: 31)" }
      conversation << { :id => 32, :comment_id => 10, :sm_type => Random.rand(3) ,:content => "This is comment-layer 3. (ID: 32)" }
      conversation << { :id => 33, :comment_id => 10, :sm_type => Random.rand(3) ,:content => "This is comment-layer 3. (ID: 33)" }
      #11
      conversation << { :id => 34, :comment_id => 11, :sm_type => Random.rand(3) ,:content => "This is comment-layer 3. (ID: 34)" }
      conversation << { :id => 35, :comment_id => 11, :sm_type => Random.rand(3) ,:content => "This is comment-layer 3. (ID: 35)" }
      conversation << { :id => 36, :comment_id => 11, :sm_type => Random.rand(3) ,:content => "This is comment-layer 3. (ID: 36)" }
      #12
      conversation << { :id => 37, :comment_id => 12, :sm_type => Random.rand(3) ,:content => "This is comment-layer 3. (ID: 37)" }
      conversation << { :id => 38, :comment_id => 12, :sm_type => Random.rand(3) ,:content => "This is comment-layer 3. (ID: 38)" }
      conversation << { :id => 39, :comment_id => 12, :sm_type => Random.rand(3) ,:content => "This is comment-layer 3. (ID: 39)" }
      #layer 4
      #13
      conversation << { :id => 40, :comment_id => 13, :sm_type => Random.rand(3) ,:content => "This is comment-layer 4. (ID: 40)" }
      conversation << { :id => 41, :comment_id => 13, :sm_type => Random.rand(3) ,:content => "This is comment-layer 4. (ID: 41)" }
      conversation << { :id => 42, :comment_id => 13, :sm_type => Random.rand(3) ,:content => "This is comment-layer 4. (ID: 42)" }
      #16
      conversation << { :id => 43, :comment_id => 16, :sm_type => Random.rand(3) ,:content => "This is comment-layer 4. (ID: 43)" }
      conversation << { :id => 44, :comment_id => 16, :sm_type => Random.rand(3) ,:content => "This is comment-layer 4. (ID: 44)" }
      conversation << { :id => 45, :comment_id => 16, :sm_type => Random.rand(3) ,:content => "This is comment-layer 4. (ID: 45)" }
      #19
      conversation << { :id => 46, :comment_id => 19, :sm_type => Random.rand(3) ,:content => "This is comment-layer 4. (ID: 46)" }
      conversation << { :id => 47, :comment_id => 19, :sm_type => Random.rand(3) ,:content => "This is comment-layer 4. (ID: 47)" }
      conversation << { :id => 48, :comment_id => 19, :sm_type => Random.rand(3) ,:content => "This is comment-layer 4. (ID: 48)" }
      #22
      conversation << { :id => 49, :comment_id => 22, :sm_type => Random.rand(3) ,:content => "This is comment-layer 4. (ID: 49)" }
      conversation << { :id => 50, :comment_id => 22, :sm_type => Random.rand(3) ,:content => "This is comment-layer 4. (ID: 50)" }
      conversation << { :id => 51, :comment_id => 22, :sm_type => Random.rand(3) ,:content => "This is comment-layer 4. (ID: 51)" }
      #25
      conversation << { :id => 52, :comment_id => 25, :sm_type => Random.rand(3) ,:content => "This is comment-layer 4. (ID: 52)" }
      conversation << { :id => 53, :comment_id => 25, :sm_type => Random.rand(3) ,:content => "This is comment-layer 4. (ID: 53)" }
      conversation << { :id => 54, :comment_id => 25, :sm_type => Random.rand(3) ,:content => "This is comment-layer 4. (ID: 54)" }
      #28
      conversation << { :id => 55, :comment_id => 28, :sm_type => Random.rand(3) ,:content => "This is comment-layer 4. (ID: 55)" }
      conversation << { :id => 56, :comment_id => 28, :sm_type => Random.rand(3) ,:content => "This is comment-layer 4. (ID: 56)" }
      conversation << { :id => 57, :comment_id => 28, :sm_type => Random.rand(3) ,:content => "This is comment-layer 4. (ID: 57)" }
      #31
      conversation << { :id => 58, :comment_id => 31, :sm_type => Random.rand(3) ,:content => "This is comment-layer 4. (ID: 58)" }
      conversation << { :id => 59, :comment_id => 31, :sm_type => Random.rand(3) ,:content => "This is comment-layer 4. (ID: 59)" }
      conversation << { :id => 60, :comment_id => 31, :sm_type => Random.rand(3) ,:content => "This is comment-layer 4. (ID: 60)" }
      #34
      conversation << { :id => 61, :comment_id => 34, :sm_type => Random.rand(3) ,:content => "This is comment-layer 4. (ID: 61)" }
      conversation << { :id => 62, :comment_id => 34, :sm_type => Random.rand(3) ,:content => "This is comment-layer 4. (ID: 62)" }
      conversation << { :id => 63, :comment_id => 34, :sm_type => Random.rand(3) ,:content => "This is comment-layer 4. (ID: 63)" }
      #37
      conversation << { :id => 64, :comment_id => 37, :sm_type => Random.rand(3) ,:content => "This is comment-layer 4. (ID: 64)" }
      conversation << { :id => 65, :comment_id => 37, :sm_type => Random.rand(3) ,:content => "This is comment-layer 4. (ID: 65)" }
      conversation << { :id => 66, :comment_id => 37, :sm_type => Random.rand(3) ,:content => "This is comment-layer 4. (ID: 66)" }
      conversations << conversation
      (1..20).each do |conversation_index|
        conversation = []
        previous_id = nil
        id = nil
        (1..Random.rand(15)).each do |comment_index|
          id = Random.rand(999999999)
          comment = { :id => id, :comment_id => previous_id, :sm_type => Random.rand(3) ,:content => "This is comment ##{comment_index}. (ID: #{id})" }
          conversation << { :comment => comment }
          previous_id = id
        end
        conversations << { :conversation => conversation }
      end
      
      response = { :conversations => conversations }
      format.json { render :json => response }
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