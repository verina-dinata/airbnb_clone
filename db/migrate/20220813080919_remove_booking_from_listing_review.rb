class RemoveBookingFromListingReview < ActiveRecord::Migration[7.0]
  def change
    remove_reference :listing_reviews, :booking, null: false, foreign_key: true
  end
end
