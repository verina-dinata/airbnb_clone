class Booking < ApplicationRecord
  belongs_to :guest, class_name: 'User'
  belongs_to :listing

  validates :start_date, :end_date, :guest_count, :payment_amount, :guest, :listing, presence: true
  validates :end_date, comparison: { greater_than: :start_date }
  validates :guest_count, numericality: { only_integer: true }

  enum :status, { pending_host_confirmation: 0, accepted_by_host: 1, cancelled_by_host: 2, cancelled_by_guest: 3 }


  def night_count
    (end_date - start_date).to_i
  end
end
