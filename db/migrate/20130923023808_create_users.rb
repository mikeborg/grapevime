class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :twitter_id
      t.string :twitter_nickname
      t.string :twitter_oauth_token
      t.string :twitter_oauth_secret
      t.timestamps
    end
  end
end
