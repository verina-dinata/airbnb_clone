class CreateListingreviews < ActiveRecord::Migration[7.0]
  def change
    create_table :listingreviews do |t|
      t.integer :cleanliness_rating
      t.integer :communication_rating
      t.integer :value_rating
      t.integer :location_rating
      t.integer :check_in_rating
      t.integer :accuracy_rating
      t.string :content
      t.references :booking, null: false, foreign_key: true

      t.timestamps
    end
  end
end
