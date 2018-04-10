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

ActiveRecord::Schema.define(version: 20180410165602) do

  create_table "addresses", force: :cascade do |t|
    t.string   "line1",      limit: 255
    t.string   "line2",      limit: 255
    t.string   "city",       limit: 255
    t.string   "state",      limit: 255
    t.integer  "zip",        limit: 4
    t.integer  "phone",      limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",    limit: 4
  end

  add_index "addresses", ["user_id"], name: "index_addresses_on_user_id", using: :btree

  create_table "requests", force: :cascade do |t|
    t.datetime "start_time"
    t.string   "place",          limit: 255
    t.integer  "duration",       limit: 4
    t.text     "observations",   limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",        limit: 4
    t.integer  "interpreter_id", limit: 4
    t.boolean  "confirmed",                    default: false
  end

  add_index "requests", ["interpreter_id"], name: "index_requests_on_interpreter_id", using: :btree
  add_index "requests", ["user_id"], name: "index_requests_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "crypted_password",          limit: 40
    t.string   "salt",                      limit: 40
    t.string   "remember_token",            limit: 255
    t.datetime "remember_token_expires_at"
    t.string   "name",                      limit: 255
    t.string   "email_address",             limit: 255
    t.boolean  "administrator",                         default: false
    t.boolean  "applicant",                             default: true
    t.boolean  "interpreter",                           default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",                     limit: 255, default: "inactive"
    t.datetime "key_timestamp"
  end

  add_index "users", ["state"], name: "index_users_on_state", using: :btree

end
