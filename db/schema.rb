# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_26_144211) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "finders", force: :cascade do |t|
    t.string "release"
    t.string "duration"
    t.string "language", default: [], array: true
    t.string "rating", default: [], array: true
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_finders_on_user_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.string "overview"
    t.string "vote_average"
    t.bigint "finder_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["finder_id"], name: "index_movies_on_finder_id"
  end

  create_table "preference_finders", force: :cascade do |t|
    t.bigint "preference_id", null: false
    t.bigint "finder_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["finder_id"], name: "index_preference_finders_on_finder_id"
    t.index ["preference_id"], name: "index_preference_finders_on_preference_id"
  end

  create_table "preferences", force: :cascade do |t|
    t.text "content", default: [], array: true
    t.string "name"
    t.bigint "finder_id"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["finder_id"], name: "index_preferences_on_finder_id"
    t.index ["user_id"], name: "index_preferences_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "user_name"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "authentication_token", limit: 30
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "finders", "users"
  add_foreign_key "movies", "finders"
  add_foreign_key "preference_finders", "finders"
  add_foreign_key "preference_finders", "preferences"
  add_foreign_key "preferences", "finders"
  add_foreign_key "preferences", "users"
end
