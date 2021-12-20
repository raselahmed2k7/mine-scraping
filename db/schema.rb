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

ActiveRecord::Schema.define(version: 2021_12_20_072941) do

  create_table "airline_flights", force: :cascade do |t|
    t.integer "ticket_airline_id"
    t.string "flight_code"
    t.float "flight_price"
    t.string "flight_changeable_status"
    t.string "flight_ticket_type"
    t.integer "ticket_airline_company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_airline_company_id"], name: "index_airline_flights_on_ticket_airline_company_id"
  end

  create_table "ticket_airline_companies", force: :cascade do |t|
    t.integer "ticket_summary_id"
    t.string "airline_company_name"
    t.float "ticket_lowest_price"
    t.integer "total_flights_available"
    t.string "ticket_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ticket_summaries", force: :cascade do |t|
    t.date "departure_date"
    t.date "return_date"
    t.string "time_from_out"
    t.string "time_to_out"
    t.datetime "search_time"
    t.integer "total_tickets_out"
    t.integer "total_tickets_in"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tickets_summaries", force: :cascade do |t|
    t.date "departure_date"
    t.date "return_date"
    t.string "time_from_out"
    t.string "time_to_out"
    t.datetime "search_time"
    t.integer "total_tickets_out"
    t.integer "total_tickets_in"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
