class CreateTicketAirlineCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :ticket_airline_companies do |t|
      t.integer :ticket_summary_id
      t.string :airline_company_name
      t.float :ticket_lowest_price
      t.integer :total_flights_available
      t.string :ticket_type
      t.references :ticket_summary, foreign_key: true
      
      t.timestamps
    end
  end
end
