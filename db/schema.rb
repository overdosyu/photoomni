# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130408221306) do

  create_table "post_likes", :force => true do |t|
    t.integer  "post_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "post_likes", ["post_id", "user_id"], :name => "index_post_likes_on_post_id_and_user_id", :unique => true
  add_index "post_likes", ["user_id"], :name => "index_post_likes_on_user_id"

  create_table "post_reviews", :force => true do |t|
    t.integer  "post_id",                    :null => false
    t.integer  "user_id",                    :null => false
    t.integer  "rating",     :default => 0
    t.text     "comment",    :default => ""
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "post_reviews", ["post_id"], :name => "index_post_reviews_on_post_id"
  add_index "post_reviews", ["user_id"], :name => "index_post_reviews_on_user_id"

  create_table "posts", :force => true do |t|
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "topic_id"
  end

  add_index "posts", ["topic_id"], :name => "index_posts_on_topic_id"
  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "topics", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "topics", ["user_id"], :name => "index_topics_on_user_id"

  create_table "user_profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "user_profiles", ["user_id"], :name => "index_user_profiles_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

end
