class SearchFields < ActiveRecord::Migration[6.1]
  def change
    create_table :search_fields do |t|
      t.integer :departure_input_date_id
      t.datetime :search_date
      t.integer :departure_airport_id
      t.integer :arrival_airport_id
      t.string :departure_time_from
      t.string :departure_time_to
      t.references :departure_date, foreign_key: true
      t.references :airport, foreign_key: true

      t.timestamps
    end
  end
end
