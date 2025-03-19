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

ActiveRecord::Schema[7.0].define(version: 2024_10_13_154839) do
  create_table "authors", force: :cascade do |t|
    t.string "authorFirstName", null: false
    t.string "authorSurname"
    t.text "authorDescription"
    t.string "birthYear"
    t.string "deathYear"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "categoryName", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "founders", force: :cascade do |t|
    t.string "name"
    t.text "bio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quote_categories", force: :cascade do |t|
    t.integer "quote_id", null: false
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_quote_categories_on_category_id"
    t.index ["quote_id"], name: "index_quote_categories_on_quote_id"
  end

  create_table "quotes", force: :cascade do |t|
    t.boolean "isPrivate", default: false, null: false
    t.text "quoteDescription", null: false
    t.text "comment"
    t.string "publicationYear"
    t.integer "user_id", null: false
    t.integer "author_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_quotes_on_author_id"
    t.index ["user_id"], name: "index_quotes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "userFirstName", null: false
    t.string "userSurname", null: false
    t.string "emailAddress", null: false
    t.string "password_digest", null: false
    t.boolean "isAdmin", default: false
    t.string "accountStatus", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["emailAddress"], name: "index_users_on_emailAddress", unique: true
  end

  add_foreign_key "quote_categories", "categories"
  add_foreign_key "quote_categories", "quotes"
  add_foreign_key "quotes", "authors"
  add_foreign_key "quotes", "users"
end
