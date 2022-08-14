class AddLongLatToListings < ActiveRecord::Migration[7.0]
  def change
    add_column :listings, :lat, :decimal, precision: 10, scale: 6
    add_column :listings, :lng, :decimal, precision: 10, scale: 6
  end
end
