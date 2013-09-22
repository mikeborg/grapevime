class AddMetricsToComments < ActiveRecord::Migration
  def change
    add_column :comments, :likes, :integer
    add_column :comments, :closes, :integer
    add_column :comments, :reports, :integer
  end
end
