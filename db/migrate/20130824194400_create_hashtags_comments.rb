class CreateHashtagsComments < ActiveRecord::Migration
  def change
    create_table :hashtags_comments do |t|
      t.belongs_to :hashtag
      t.belongs_to :comment
      
      t.timestamps
    end
  end
end
