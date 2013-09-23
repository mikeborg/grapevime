class CreateHashtagsComments < ActiveRecord::Migration
  def change
    create_table :hashtags_comments do |t|
      t.belongs_to :hashtag
      t.belongs_to :comment
      
      t.timestamps
    end
    add_index(:hashtags_comments, [:comment_id, :hashtag_id], :unique => true)
  end
end
