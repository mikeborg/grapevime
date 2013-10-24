class Search < ActiveRecord::Base
  
  def hashtag_terms
    parse_for_hashtags(self.q)
  end
  
  def results=(results)
    @conversations = results
  end
  
  def conversations
    @conversations
  end
  
  private
  
  def parse_for_hashtags(q)
    hashtags = q.scan(/#\S+/)
  end
  
end
