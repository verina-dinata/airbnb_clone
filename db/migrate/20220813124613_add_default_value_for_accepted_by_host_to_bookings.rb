class AddDefaultValueForAcceptedByHostToBookings < ActiveRecord::Migration[7.0]
  def change
    change_column :bookings, :accepted_by_host, :boolean, default: false
  end
end
