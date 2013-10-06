class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      #enable_extension "hstore"
      t.integer :comment_id
      t.integer :popularity
      t.text :message
      t.string :source_data
      t.string :sm_type
      t.integer :closes
      t.integer :likes
      t.integer :reports
      t.integer :views
      t.integer :user_id
      t.integer :facebook_id
      t.integer :twitter_id
      
      t.timestamps
    end
  end
end
