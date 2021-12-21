class Searches < ActiveRecord::Migration[6.1]
  def change
    create_table :searches do |t|
      t.datetime :search_date
      t.integer :arrival_airport_id
      t.string :departure_time_from
      t.string :departure_time_to
      t.references :departure_date, foreign_key: true
      t.references :airport, foreign_key: true

      t.timestamps
    end
  end
end
