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

ActiveRecord::Schema.define(version: 20150223103102) do

  create_table "cuisines", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cuisines_places", id: false, force: :cascade do |t|
    t.integer "cuisine_id"
    t.integer "place_id"
  end

  add_index "cuisines_places", ["cuisine_id"], name: "index_cuisines_places_on_cuisine_id"
  add_index "cuisines_places", ["place_id"], name: "index_cuisines_places_on_place_id"

  create_table "locksmith_applications", force: :cascade do |t|
    t.string   "name",       limit: 30
    t.string   "key"
    t.integer  "user_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "locksmith_applications", ["key"], name: "index_locksmith_applications_on_key", unique: true
  add_index "locksmith_applications", ["user_id"], name: "index_locksmith_applications_on_user_id"

  create_table "locksmith_users", force: :cascade do |t|
    t.string   "name",            limit: 30
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "admin"
  end

  add_index "locksmith_users", ["email"], name: "index_locksmith_users_on_email", unique: true

  create_table "places", force: :cascade do |t|
    t.string   "name"
    t.float    "rating"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "telephone"
    t.string   "homepage"
    t.string   "street"
    t.string   "zip"
    t.string   "city"
    t.string   "image_url"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "place_id"
    t.integer  "user_id"
    t.float    "rating"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "reviews", ["place_id"], name: "index_reviews_on_place_id"
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
  end

end
