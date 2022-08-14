class BookingsController < ApplicationController
  before_action :set_booking, only: [:show]

  def index
    @bookings = Booking.all
    @past_bookings = @bookings.select { |booking| booking.end_date < Date.today }
    @upcoming_bookings = @bookings.select { |booking| booking.end_date > Date.today }
  end

  def show
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])

  end
end
