class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      #enable_extension "hstore"
      t.belongs_to :comment
      t.string :message
      t.string :source_data
      t.string :sm_type
      
      t.timestamps
    end
  end
end
