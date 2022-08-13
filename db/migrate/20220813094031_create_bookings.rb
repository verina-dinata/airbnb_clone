class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.date :start_date
      t.date :end_date
      t.text :additional_requests
      t.boolean :accepted_by_host
      t.integer :guest_count
      t.float :payment_amount

      t.timestamps
    end
  end
end
