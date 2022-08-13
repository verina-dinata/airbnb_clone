class ChangeColumnsToBookings < ActiveRecord::Migration[7.0]
  def change
    remove_column :bookings, :accepted_by_host
    add_column :bookings, :status, :integer, default: 0
  end
end
