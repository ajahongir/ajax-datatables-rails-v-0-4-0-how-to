class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.references :country
      t.string :name
      t.string :iata
      t.string :timezone
    end
  end
end
