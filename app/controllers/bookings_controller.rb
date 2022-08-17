class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :cancel, :host_cancel, :host_accept]
  before_action :set_listing, only: [:new]
  skip_before_action :verify_authenticity_token, only: [:cancel, :host_cancel, :host_accept]

  def index
    @bookings = policy_scope(Booking)
    @upcoming_bookings = @bookings.select { |booking|
      (booking.accepted_by_host? || booking.pending_host_confirmation?) && booking.end_date > Date.today }
    @past_bookings = @bookings.select { |booking| booking.end_date < Date.today && booking.accepted_by_host? }
    @cancelled_bookings = @bookings.select { |booking| booking.cancelled_by_guest? || booking.cancelled_by_host? }
  end

  def show
    authorize @booking
    @markers = [
      {
        lat: @booking.listing.latitude,
        lng: @booking.listing.longitude,
        info_window: render_to_string(partial: "info_window", locals: { booking: @booking })
      }

    ]
  end

  # http://localhost:3000/bookings/new?start_date=2022-10-10&end_date=2022-10-18&guest_count=5&listing_id=40
  def new

    # TODO: make sure listing don't belong to the current user :D lol
    # redirect with notice
    # if listing.host == current_user

    @booking = Booking.new(
      start_date: params[:start_date],
      end_date: params[:end_date],
      guest_count: params[:guest_count],
      listing: @listing
    )

    @guest_count = params[:guest_count]
    authorize @booking
  end

  def create
    @booking = Booking.new(booking_params)
    authorize @booking
    @booking.guest = current_user

    if @booking.save
      redirect_to booking_path(@booking), notice: "You have submitted your booking request!."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @booking
  end

  def update
    authorize @booking
  end

  def cancel
    authorize @booking

    @booking.cancelled_by_guest!
    render json: { message: "Cancelled by guest successful" }, status: :ok
  end

  def host_cancel
    authorize @booking

    @booking.cancelled_by_host!
    render json: { message: "Cancelled by host successful" }, status: :ok
  end

  def host_accept
    authorize @booking

    @booking.accepted_by_host!
    render json: { message: "Accepted by host successful" }, status: :ok
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def set_listing
    @listing = Listing.find(params[:listing_id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :additional_requests, :guest_count, :listing_id)
  end

  def calculate_total_nights_amount
    @booking.listing.price_per_night * @booking.night_count
  end

  def total_amount
    service_fee = @booking.listing.service_fee
    cleaning_fee = @booking.listing.cleaning_fee
    calculate_total_nights_amount + service_fee + cleaning_fee
  end
end
