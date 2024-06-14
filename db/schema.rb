# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_06_14_135938) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assistances", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "event_id", null: false
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_assistances_on_event_id"
    t.index ["user_id"], name: "index_assistances_on_user_id"
  end

  create_table "bookclubs", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "organizer_id", null: false
    t.string "location"
    t.integer "max_members"
    t.string "privacy"
    t.string "genre"
    t.date "meeting_schedule"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organizer_id"], name: "index_bookclubs_on_organizer_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.string "author"
    t.bigint "user_id", null: false
    t.text "description"
    t.string "genre"
    t.integer "rating"
    t.string "language"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.index ["user_id"], name: "index_books_on_user_id"
  end

  create_table "chatrooms", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "address"
    t.bigint "organizer_id", null: false
    t.integer "max_assistants"
    t.string "privacy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organizer_id"], name: "index_events_on_organizer_id"
  end

  create_table "loans", force: :cascade do |t|
    t.bigint "book_id", null: false
    t.bigint "owner_id", null: false
    t.bigint "borrower_id", null: false
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "start_date"
    t.date "end_date"
    t.string "extension"
    t.index ["book_id"], name: "index_loans_on_book_id"
    t.index ["borrower_id"], name: "index_loans_on_borrower_id"
    t.index ["owner_id"], name: "index_loans_on_owner_id"
  end

  create_table "members", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "bookclub_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bookclub_id"], name: "index_members_on_bookclub_id"
    t.index ["user_id"], name: "index_members_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "chatroom_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chatroom_id"], name: "index_messages_on_chatroom_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "participants", force: :cascade do |t|
    t.bigint "chatroom_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chatroom_id"], name: "index_participants_on_chatroom_id"
    t.index ["user_id"], name: "index_participants_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "user_reviewed_id", null: false
    t.bigint "user_reviewer_id", null: false
    t.bigint "loan_id", null: false
    t.integer "rating"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["loan_id"], name: "index_reviews_on_loan_id"
    t.index ["user_reviewed_id"], name: "index_reviews_on_user_reviewed_id"
    t.index ["user_reviewer_id"], name: "index_reviews_on_user_reviewer_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address"
    t.string "nickname"
    t.boolean "admin", default: false
    t.boolean "blocked", default: false
    t.integer "Currentloans", default: 0
    t.float "latitude"
    t.float "longitude"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "assistances", "events"
  add_foreign_key "assistances", "users"
  add_foreign_key "bookclubs", "users", column: "organizer_id"
  add_foreign_key "books", "users"
  add_foreign_key "events", "users", column: "organizer_id"
  add_foreign_key "loans", "books"
  add_foreign_key "loans", "users", column: "borrower_id"
  add_foreign_key "loans", "users", column: "owner_id"
  add_foreign_key "members", "bookclubs"
  add_foreign_key "members", "users"
  add_foreign_key "messages", "chatrooms"
  add_foreign_key "messages", "users"
  add_foreign_key "participants", "chatrooms"
  add_foreign_key "participants", "users"
  add_foreign_key "reviews", "loans"
  add_foreign_key "reviews", "users", column: "user_reviewed_id"
  add_foreign_key "reviews", "users", column: "user_reviewer_id"
end
