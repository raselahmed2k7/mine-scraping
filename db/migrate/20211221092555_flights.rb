class Flights < ActiveRecord::Migration[6.1]
  def change
    create_table :flights do |t|
      t.string :code
      t.float :price
      t.string :changeable_status
      t.string :flight_seat
      t.string :flight_type
      t.float :flight_type_discount
      t.references :airline, foreign_key: true
      t.references :search, foreign_key: true

      t.timestamps
    end
  end
end
