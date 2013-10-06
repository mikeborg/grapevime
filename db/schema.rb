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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20130924030832) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "attags", force: true do |t|
    t.string   "tag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attags_comments", force: true do |t|
    t.integer  "attag_id"
    t.integer  "comment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attags_comments", ["comment_id", "attag_id"], name: "index_attags_comments_on_comment_id_and_attag_id", unique: true, using: :btree

  create_table "comments", force: true do |t|
    t.integer  "comment_id"
    t.integer  "popularity"
    t.text     "message"
    t.string   "source_data"
    t.string   "sm_type"
    t.integer  "closes"
    t.integer  "likes"
    t.integer  "reports"
    t.integer  "views"
    t.integer  "user_id"
    t.integer  "facebook_id"
    t.integer  "twitter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments_closes", force: true do |t|
    t.integer  "user_id"
    t.integer  "comment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments_closes", ["comment_id", "user_id"], name: "index_comments_closes_on_comment_id_and_user_id", unique: true, using: :btree

  create_table "comments_likes", force: true do |t|
    t.integer  "comment_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments_likes", ["comment_id", "user_id"], name: "index_comments_likes_on_comment_id_and_user_id", unique: true, using: :btree

  create_table "comments_reports", force: true do |t|
    t.integer  "user_id"
    t.integer  "comment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments_reports", ["comment_id", "user_id"], name: "index_comments_reports_on_comment_id_and_user_id", unique: true, using: :btree

  create_table "comments_vimes", force: true do |t|
    t.integer  "user_id"
    t.integer  "comment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments_vimes", ["comment_id", "user_id"], name: "index_comments_vimes_on_comment_id_and_user_id", unique: true, using: :btree

  create_table "hashtags", force: true do |t|
    t.string   "tag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hashtags_comments", force: true do |t|
    t.integer  "hashtag_id"
    t.integer  "comment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hashtags_comments", ["comment_id", "hashtag_id"], name: "index_hashtags_comments_on_comment_id_and_hashtag_id", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.integer  "twitter_id"
    t.string   "twitter_nickname"
    t.string   "twitter_oauth_token"
    t.string   "twitter_oauth_secret"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
