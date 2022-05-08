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

ActiveRecord::Schema[7.0].define(version: 2022_05_08_084459) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "escrow_nfts", force: :cascade do |t|
    t.string "mongo_id"
    t.string "lms_id"
    t.json "nft", default: {}
    t.string "nft_number"
    t.string "image_url"
    t.string "nft_address"
    t.decimal "price", precision: 40, scale: 20
    t.string "seller"
    t.string "mint"
    t.string "nft_vault"
    t.string "seller_receive_account"
    t.datetime "escrow_date"
    t.integer "kind"
    t.string "human_name"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "histories", force: :cascade do |t|
    t.string "attribute_name"
    t.string "before_value"
    t.string "after_value"
    t.integer "owner_id"
    t.string "historyable_type"
    t.bigint "historyable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["historyable_type", "historyable_id"], name: "index_histories_on_historyable"
  end

end
