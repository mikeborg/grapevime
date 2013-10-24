class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      #enable_extension "hstore"
      t.integer :user_id
      t.integer :comment_id
      t.integer :popularity
 
      # General
      t.string :sm_type # social media type: 'facebook' , 'twitter', etc.
      t.string :sm_screen_name
      t.string :sm_user_id
      t.string :sm_status_id
      t.string :source_data
      t.text :message
      #Twitter specific
      t.integer :tw_retweet_count
      t.integer :tw_favorite_count
      t.integer :tw_user_followers_count
      t.integer :tw_user_favorites_count
      t.integer :tw_user_statuses_count
      #Facebook specific
      #t.integer :facebook_id
      #Grapevime specific
      t.integer :closes
      t.integer :likes
      t.integer :reports
      t.integer :views
      
      t.timestamps
    end
  end
end
