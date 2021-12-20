class CreateAirlineFlights < ActiveRecord::Migration[5.2]
  def change
    create_table :airline_flights do |t|
      t.integer :ticket_airline_id
      t.string :flight_code
      t.float :flight_price
      t.string :flight_changeable_status
      t.string :flight_ticket_type
      t.references :ticket_airline_company, foreign_key: true
      
      t.timestamps
    end
  end
end
