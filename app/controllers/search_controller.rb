class SearchController < ApplicationController
  def index
    
    respond_to do |format|
      
      conversations = []
      (1..20).each do |conversation_index|
        conversation = []
        previous_id = nil
        (1..Random.rand(15)).each do |comment_index|
          id = Random.rand(999999999)
          comment = { :id => id, :comment_id => previous_id, :sm_type => Random.rand(3) ,:content => "This is comment ##{comment_index}." }
          conversation << { :comment => comment }
          previous_id = id
        end
        conversations << { :conversation => conversation }
      end
      
      response = { :conversations => conversations }
      format.json { render :json => response }
    end
  end
end
