class AddGvLikesToComments < ActiveRecord::Migration
  def change
    add_column :comments, :gv_likes, :integer
  end
end
