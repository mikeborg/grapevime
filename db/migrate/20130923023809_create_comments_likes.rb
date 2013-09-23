class CreateCommentsLikes < ActiveRecord::Migration
  def change
    create_table :comments_likes do |t|
      t.belongs_to :comment
      t.belongs_to :user

      t.timestamps
    end
    add_index(:comments_likes, [:comment_id, :user_id], :unique => true)
  end
end
