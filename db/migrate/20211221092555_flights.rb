class Flights < ActiveRecord::Migration[6.1]
  def change
    create_table :flights do |t|
      t.integer :search_id
      t.string :code
      t.float :price
      t.integer :flight_airline_id
      t.string :changeable_status
      t.string :flight_type
      t.float :flight_type_discount
      t.references :airline, foreign_key: true
      t.references :search_field, foreign_key: true

      t.timestamps
    end
  end
end
