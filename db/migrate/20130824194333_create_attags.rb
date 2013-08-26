class CreateAttags < ActiveRecord::Migration
  def change
    create_table :attags do |t|
      t.string :tag

      t.timestamps
    end
  end
end
