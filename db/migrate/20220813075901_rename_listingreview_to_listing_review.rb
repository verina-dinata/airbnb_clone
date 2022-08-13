class RenameListingreviewToListingReview < ActiveRecord::Migration[7.0]
  def change
    rename_table :listingreview, :listing_review
  end
end
