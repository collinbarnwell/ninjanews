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

ActiveRecord::Schema.define(version: 20131116053706) do

  create_table "article_reads", force: true do |t|
    t.integer "user_id"
    t.integer "article_id"
  end

  create_table "articles", force: true do |t|
    t.string   "title"
    t.string   "image"
    t.string   "content"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "feed_id"
  end

  create_table "articles_newspapers", id: false, force: true do |t|
    t.integer "newspaper_id"
    t.integer "article_id"
  end

  create_table "feed_scores", force: true do |t|
    t.integer  "feed_id"
    t.integer  "user_id"
    t.float    "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feeds", force: true do |t|
    t.integer  "source_id"
    t.string   "url"
    t.string   "section"
    t.integer  "area_importance"
    t.boolean  "is_local_news",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interest_answers", force: true do |t|
    t.integer  "interest_question_id"
    t.integer  "user_id"
    t.integer  "interest_rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interest_questions", force: true do |t|
    t.text     "question_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "newspapers", force: true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relation_levels", force: true do |t|
    t.integer  "feed_id"
    t.integer  "interest_question_id"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sources", force: true do |t|
    t.string   "title"
    t.string   "url"
    t.string   "area"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "zipcode"
    t.string   "area"
    t.string   "password"
    t.string   "password_confirmation"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.boolean  "is_admin",              default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
