class User < ActiveRecord::Base
  #has_many :comments_likes
  #has_many :likes, -> { distinct }, through: :comments_likes, source: :user
  
  def self.from_omniauth(auth)
    if auth["provider"] == "twitter"
      puts "provider: twitter"
      user = where(:twitter_id => auth["uid"]).first || create_from_omniauth(auth)
      user.twitter_oauth_token = auth['credentials']['token']
      user.twitter_oauth_secret = auth['credentials']['secret']
      user.save!
      user
    end
  end

  def self.create_from_omniauth(auth) # this needs to handle adding a provider id
    create! do |user|
      if auth['provider'] == 'twitter'
        user.twitter_id = auth['uid']
        user.twitter_nickname = auth['info']['nickname']
      end
    end
  end
  
  def twitter
    if twitter_id && twitter_oauth_token && twitter_oauth_secret
      @twitter ||= Twitter::Client.new(oauth_token: twitter_oauth_token, oauth_token_secret: twitter_oauth_secret)
    end
  end
end
