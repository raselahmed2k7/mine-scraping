class CreateTicketSummaries < ActiveRecord::Migration[5.2]
  def change
    create_table :ticket_summaries do |t|
      t.date :departure_date
      t.date :return_date
      t.string :time_from_out
      t.string :time_to_out
      t.datetime :search_time
      t.integer :total_tickets_out
      t.integer :total_tickets_in

      t.timestamps
    end
  end
end
