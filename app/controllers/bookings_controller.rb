class BookingsController < ApplicationController
  before_action :set_booking, only: [:show]

  def index
    @bookings = policy_scope(Booking)
    @past_bookings = @bookings.select { |booking| booking.end_date < Date.today }
    @upcoming_bookings = @bookings.select { |booking| booking.end_date > Date.today }
  end

  def show
    authorize @booking
    @start_date_day = @booking.start_date.strftime('%A')
    @end_date_day = @booking.end_date.strftime('%A')
    @start_date = beautify_start_date
    @end_date = beautify_end_date
    @night_count = (@booking.end_date - @booking.start_date).to_i
    @markers = [
      {
        lat: @booking.listing.latitude,
        lng: @booking.listing.longitude
      }
    ]
  end

  def new
    @booking = Booking.new(booking_params)
    authorize @booking
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.guest = current_user
    # @booking.listing =
    authorize @booking
    if @booking.save!
      redirect_to booking_path(booking), notice: "You have submitted your booking request!."
    else
      render :new
    end
  end

  def edit
    authorize @booking
  end

  def update
    authorize @booking
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :additional_requests, :guest_count, :payment_amount)
  end

  def beautify_start_date
    start_day = find_day(@booking.start_date)
    start_month = find_month(@booking.start_date)
    start_year = find_year(@booking.start_date)
    return "#{start_day} #{start_month} #{start_year}"
  end

  def beautify_end_date
    end_day = find_day(@booking.end_date)
    end_month = find_month(@booking.end_date)
    end_year = find_year(@booking.end_date)
    return "#{end_day} #{end_month} #{end_year}"
  end

  def find_day(date)
    date.strftime('%d').to_s
  end

  def find_month(date)
    date.strftime('%h').to_s
  end

  def find_year(date)
    date.strftime('%Y').to_s
  end
end
