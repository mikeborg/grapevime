class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      #enable_extension "hstore"
      t.belongs_to :comment
      t.integer :popularity
      t.string :message
      t.string :source_data
      t.string :sm_type
      t.integer :gv_likes
      
      t.timestamps
    end
  end
end
