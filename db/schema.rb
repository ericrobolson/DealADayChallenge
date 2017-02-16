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

ActiveRecord::Schema.define(version: 20161210200801) do

  create_table "file_uploads", force: :cascade do |t|
    t.string   "file_path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "imports", force: :cascade do |t|
    t.datetime "time_run"
    t.string   "import_file"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "items", force: :cascade do |t|
    t.string   "description"
    t.float    "price"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "merchants", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "purchasers", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "purchases", force: :cascade do |t|
    t.integer  "purchase_count"
    t.integer  "purchasers_id"
    t.integer  "items_id"
    t.integer  "merchants_id"
    t.integer  "imports_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["imports_id"], name: "index_purchases_on_imports_id"
    t.index ["items_id"], name: "index_purchases_on_items_id"
    t.index ["merchants_id"], name: "index_purchases_on_merchants_id"
    t.index ["purchasers_id"], name: "index_purchases_on_purchasers_id"
  end

end
