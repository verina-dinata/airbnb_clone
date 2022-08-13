class Booking < ApplicationRecord
  belongs_to :guest, class_name: 'User'
  belongs_to :listing

  validates :start_date, :end_date, :guest_count, :payment_amount, :guest, :listing, presence: true
  validates :end_date, comparison: { greater_than: :start_date }
  validates :guest_count, :payment_amount, numericality: { only_integer: true }
end
