class Airlines < ActiveRecord::Migration[6.1]
  def change
     create_table :airlines do |t|
      t.string :name
      
      t.timestamps
    end
  end
end
