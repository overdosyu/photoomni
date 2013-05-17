class CreatePostReviews < ActiveRecord::Migration
  def change
    create_table :post_reviews do |t|
      t.integer :post_id, null: false
      t.integer :user_id, null: false
      t.integer :rating,  default: 0
      t.text    :comment, default: ""
      t.timestamps
    end
    add_index :post_reviews, :post_id
    add_index :post_reviews, :user_id
  end
end
