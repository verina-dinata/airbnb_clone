class AddListingToListingReview < ActiveRecord::Migration[7.0]
  def change
    add_column :listing, :listing_id, :integer
  end
end
