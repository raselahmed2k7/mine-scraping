class DepartureDates < ActiveRecord::Migration[6.1]
  def change
    create_table :departure_dates do |t|
      t.date :departure_date
      
      t.timestamps
    end
  end
end
