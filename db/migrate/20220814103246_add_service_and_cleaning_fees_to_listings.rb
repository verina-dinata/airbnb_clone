class AddServiceAndCleaningFeesToListings < ActiveRecord::Migration[7.0]
  def change
    add_column :listings, :service_fee, :integer
    add_column :listings, :cleaning_fee, :integer
  end
end
