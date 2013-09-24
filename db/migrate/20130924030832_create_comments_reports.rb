class CreateCommentsReports < ActiveRecord::Migration
  def change
    create_table :comments_reports do |t|
      t.belongs_to :user
      t.belongs_to :comment
    
      t.timestamps
    end
    add_index(:comments_reports, [:comment_id, :user_id], :unique => true)
  end
end
