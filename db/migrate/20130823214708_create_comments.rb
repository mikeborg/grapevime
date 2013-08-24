class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      enable_extension "hstore"
      t.hstore :content
      t.timestamps
    end
  end
end
