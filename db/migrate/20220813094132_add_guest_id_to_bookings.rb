class AddGuestIdToBookings < ActiveRecord::Migration[7.0]
  def change
    add_reference :bookings, :guest, foreign_key: { to_table: :users }
  end
end
