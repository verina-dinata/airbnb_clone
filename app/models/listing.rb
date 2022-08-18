class Listing < ApplicationRecord
  belongs_to :host, class_name: 'User'
  has_many :bookings
  has_many_attached :images

  validates :title, presence: true, length: { minimum: 6, maximum: 50, too_long: "Your title should be 50 chars max.",
                                              too_short: "Your title should be 6 chars min." }
  validates :description, presence: true, length: { minimum: 20, maximum: 500, too_long: "Your description should be 500 chars max.",
                                                    too_short: "Your description should be 20 chars min." }
  validates :country, presence: true
  validates :address, presence: true, uniqueness: true
  validates :bedroom_count, :bathroom_count, :bed_count, :guest_count, presence: true, numericality: { only_integer: true }
  validates :price_per_night, :service_fee, :cleaning_fee, presence: true, numericality: { greater_than: 0, less_than: 10_000 }

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
