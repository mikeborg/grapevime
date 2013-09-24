class CreateAttagsComments < ActiveRecord::Migration
  def change
    create_table :attags_comments do |t|
      t.belongs_to :attag
      t.belongs_to :comment
      
      t.timestamps
    end
    add_index(:attags_comments, [:comment_id, :attag_id], :unique => true)
  end
end
