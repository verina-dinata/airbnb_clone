class CreateListings < ActiveRecord::Migration[7.0]
  def change
    create_table :listings do |t|
      t.string :title
      t.text :description
      t.string :country
      t.string :address
      t.float :price_per_night
      t.integer :bedroom_count
      t.integer :bathroom_count
      t.integer :guest_count
      t.integer :bed_count
      t.text :house_rules

      t.timestamps
    end
  end
end
