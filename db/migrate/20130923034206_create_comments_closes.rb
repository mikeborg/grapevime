class CreateCommentsCloses < ActiveRecord::Migration
  def change
    create_table :comments_closes do |t|
      t.belongs_to :user
      t.belongs_to :comment
      
      t.timestamps
    end
    add_index(:comments_closes, [:comment_id, :user_id], :unique => true)
  end
end
