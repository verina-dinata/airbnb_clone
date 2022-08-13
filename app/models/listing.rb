class Listing < ApplicationRecord
  validates :title, presence: true, length: { minimum: 6 }
  validates :description, :country, presence: true
  validates :address, presence: true, uniqueness: true
  validates :bedroom_count, :bathroom_count, :bed_count, :guest_count, presence: true, numericality: { only_integer: true }
end
