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

ActiveRecord::Schema.define(version: 20180407144718) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "downloads", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "stream_id"
    t.index ["stream_id"], name: "index_downloads_on_stream_id"
    t.index ["user_id"], name: "index_downloads_on_user_id"
  end

  create_table "inputs", force: :cascade do |t|
    t.integer "line"
    t.json "content"
    t.bigint "download_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["download_id"], name: "index_inputs_on_download_id"
  end

  create_table "output_errors", force: :cascade do |t|
    t.bigint "stream_id"
    t.bigint "download_id"
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["download_id"], name: "index_output_errors_on_download_id"
    t.index ["stream_id"], name: "index_output_errors_on_stream_id"
  end

  create_table "outputs", force: :cascade do |t|
    t.integer "line"
    t.json "content"
    t.bigint "download_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["download_id"], name: "index_outputs_on_download_id"
  end

  create_table "streams", force: :cascade do |t|
    t.string "name"
    t.text "code"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_streams_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "downloads", "streams"
  add_foreign_key "downloads", "users"
  add_foreign_key "inputs", "downloads"
  add_foreign_key "output_errors", "downloads"
  add_foreign_key "output_errors", "streams"
  add_foreign_key "outputs", "downloads"
  add_foreign_key "streams", "users"
end
