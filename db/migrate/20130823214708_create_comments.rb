class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      #enable_extension "hstore"
      t.belongs_to :comment
      t.integer :popularity
      t.text :message
      t.string :source_data
      t.string :sm_type
      t.integer :closes
      t.integer :likes
      t.integer :reports
      t.integer :views
      
      t.timestamps
    end
  end
end
