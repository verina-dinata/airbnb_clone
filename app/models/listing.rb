class Listing < ApplicationRecord
  belongs_to :host, class_name: 'User'
  has_many :bookings
  has_many_attached :images

  validates :title, presence: true, length: { minimum: 6, maximum: 50, too_long: "Your title should be %{count} chars max." }
  validates :description, presence: true, length: { minimum: 20, maximum: 500, too_long: "Your description should be %{count} chars max." }
  validates :country, presence: true
  validates :address, presence: true, uniqueness: true
  validates :bedroom_count, :bathroom_count, :bed_count, :guest_count, presence: true, numericality: { only_integer: true }

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
