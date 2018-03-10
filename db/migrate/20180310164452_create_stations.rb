class CreateStations < ActiveRecord::Migration[5.1]
  def change
    create_table :stations do |t|
      t.string :neighborhood
      t.string :station
      t.integer :code
      t.string :address
      t.integer :number
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
