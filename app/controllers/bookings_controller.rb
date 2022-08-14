class BookingsController < ApplicationController
  before_action :set_booking, only: [:show]

  def index
    @bookings = Booking.all
    @past_bookings = @bookings.select { |booking| booking.end_date < Date.today }
    @upcoming_bookings = @bookings.select { |booking| booking.end_date > Date.today }

  end

  def show
    @start_date_day = @booking.start_date.strftime('%A')
    @end_date_day = @booking.end_date.strftime('%A')
    start_day = @booking.start_date.strftime('%d').to_s
    end_day = @booking.end_date.strftime('%d').to_s
    start_month = @booking.start_date.strftime('%h').to_s
    end_month = @booking.end_date.strftime('%h').to_s
    start_year = @booking.start_date.strftime('%Y').to_s
    end_year = @booking.end_date.strftime('%Y').to_s
    @start_date = "#{start_day} #{start_month} #{start_year}"
    @end_date = "#{end_day} #{end_month} #{end_year}"
    @night_count = (@booking.end_date - @booking.start_date).to_i
    @markers = [
      {
        lat: @booking.listing.latitude,
        lng: @booking.listing.longitude
      }
    ]
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])

  end
end
