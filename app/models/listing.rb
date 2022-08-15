class Listing < ApplicationRecord
  belongs_to :host, class_name: 'User'

  validates :title, presence: true, length: { minimum: 6 }
  validates :description, :country, presence: true
  validates :address, presence: true, uniqueness: true
  validates :bedroom_count, :bathroom_count, :bed_count, :guest_count, presence: true, numericality: { only_integer: true }

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
