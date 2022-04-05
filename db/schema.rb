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

ActiveRecord::Schema.define(version: 2021_11_20_011424) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_accounts_on_email", unique: true
    t.index ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true
  end

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cart_items", force: :cascade do |t|
    t.integer "quantity"
    t.bigint "product_id", null: false
    t.bigint "cart_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["product_id"], name: "index_cart_items_on_product_id"
  end

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "account_id"
  end

  create_table "cattle_nums", force: :cascade do |t|
    t.bigint "brand_id", null: false
    t.date "date"
    t.integer "num"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["brand_id"], name: "index_cattle_nums_on_brand_id"
  end

  create_table "companies", force: :cascade do |t|
    t.text "name"
    t.integer "account_id"
    t.text "postal_code"
    t.text "address"
    t.text "representative_name"
    t.text "co_number"
    t.date "co_registration_date"
    t.string "farmer"
    t.string "wholesale"
    t.string "retail"
    t.string "restaurant"
    t.string "homemeal"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "creditcards", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "payjp_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_creditcards_on_account_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "quantity"
    t.string "settlement_flag"
    t.bigint "account_id", null: false
    t.bigint "product_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_orders_on_account_id"
    t.index ["product_id"], name: "index_orders_on_product_id"
  end

  create_table "product_prices", force: :cascade do |t|
    t.date "price_date"
    t.integer "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "brand_id"
    t.index ["brand_id"], name: "index_product_prices_on_brand_id"
  end

  create_table "products", force: :cascade do |t|
    t.text "callput"
    t.date "settlement_date"
    t.date "closing_date"
    t.integer "exercise_price"
    t.integer "option_premium"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "brand_id"
    t.index ["brand_id"], name: "index_products_on_brand_id"
  end

  add_foreign_key "cart_items", "carts"
  add_foreign_key "cart_items", "products"
  add_foreign_key "cattle_nums", "brands"
  add_foreign_key "creditcards", "accounts"
  add_foreign_key "orders", "accounts"
  add_foreign_key "orders", "products"
  add_foreign_key "product_prices", "brands"
end
