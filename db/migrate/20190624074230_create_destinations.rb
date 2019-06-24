class CreateDestinations < ActiveRecord::Migration[5.2]
  def change
    create_table :destinations do |t|
      t.string :destination_name
      t.float :transport_price
      t.string :price_currency, default: "EUR"
      t.string :photo_link

      t.timestamps
    end
  end
end
