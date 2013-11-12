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

ActiveRecord::Schema.define(version: 20131111010805) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

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
    t.integer  "source_id"
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
