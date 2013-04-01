class ChangePosts < ActiveRecord::Migration
  def change
    add_column :posts, :topic_id, :integer
    remove_column :posts, :title
    add_index :posts, :topic_id
  end
end
