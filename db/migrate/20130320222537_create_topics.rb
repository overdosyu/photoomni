class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.references :user
      t.string :title

      t.timestamps
    end
    add_index :topics, :user_id
  end
end
