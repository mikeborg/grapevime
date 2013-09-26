class CreateCommentsVimes < ActiveRecord::Migration
  def change
    create_table :comments_vimes do |t|
      t.belongs_to :user
      t.belongs_to :comment
      
      t.timestamps
    end
    add_index(:comments_vimes, [:comment_id, :user_id], :unique => true)
  end
end
