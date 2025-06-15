class CreateCities < ActiveRecord::Migration[8.0]
  def change
    create_table :cities do |t|
      t.string :city_name
      t.string :zip_code
      t.timestamps
    end
    add_index :cities, [ :city_name, :zip_code ], unique: true
  end
end
