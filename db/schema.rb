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

ActiveRecord::Schema.define(version: 2021_12_21_092555) do

  create_table "airlines", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "airports", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "departure_dates", force: :cascade do |t|
    t.date "departure_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "flights", force: :cascade do |t|
    t.string "code"
    t.float "price"
    t.string "changeable_status"
    t.string "flight_seat"
    t.string "flight_type"
    t.float "flight_type_discount"
    t.integer "airline_id"
    t.integer "search_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["airline_id"], name: "index_flights_on_airline_id"
    t.index ["search_id"], name: "index_flights_on_search_id"
  end

  create_table "searches", force: :cascade do |t|
    t.datetime "search_date"
    t.integer "arrival_airport_id"
    t.string "departure_time_from"
    t.string "departure_time_to"
    t.integer "departure_date_id"
    t.integer "airport_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["airport_id"], name: "index_searches_on_airport_id"
    t.index ["departure_date_id"], name: "index_searches_on_departure_date_id"
  end

  add_foreign_key "flights", "airlines"
  add_foreign_key "flights", "searches"
  add_foreign_key "searches", "airports"
  add_foreign_key "searches", "departure_dates"
end
