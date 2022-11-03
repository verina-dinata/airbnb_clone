class ListingsController < ApplicationController
  before_action :set_listing, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @listings = Listing.all
  end

  def my_listings
    authorize Listing

    @listings = current_user.listings.includes(:bookings)
    bookings = @listings.map{ |l| l.bookings }.flatten.sort_by{ |b| b.start_date}
    @pending_bookings = bookings.select { |b| b.pending_host_confirmation? }
    @upcoming_bookings = bookings.select { |b| b.accepted_by_host? && b.start_date > Date.today }
    @past_bookings = bookings.select { |b| b.accepted_by_host? && b.end_date < Date.today}
    @cancelled_bookings = bookings.select { |b| b.cancelled_by_host?}
  end

  def show
    authorize @listing
    @booking = Booking.new
    @marker = [
      {
        lat: @listing.latitude,
        lng: @listing.longitude
      }
    ]
  end

  def new
    @listing = Listing.new
    authorize @listing
  end

  def create
    @listing = Listing.new(listing_params)

    @listing.host = current_user
    authorize @listing
    if @listing.save
      redirect_to @listing, notice: "Listing was successfully created."
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    authorize @listing
  end

  def update
    authorize @listing
    if @listing.update(listing_params)
      redirect_to @listing, notice: "Listing has been updated."
    else
      render :edit
    end
  end

  def destroy
    authorize @listing
    @listing.destroy
    redirect_to my_listings_path, status: :see_other, notice: "Listing was successfully destroyed."
  end

  private

  def set_listing
    @listing = Listing.find(params[:id])
  end

  def listing_params
    params.require(:listing).permit(:title, :description, :address, :country, :price_per_night, :bedroom_count,
                                    :bathroom_count, :bed_count, :guest_count, :house_rules, :service_fee, :cleaning_fee, images: [])
  end
end
