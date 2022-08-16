class ListingsController < ApplicationController
  before_action :set_listing, only: %i[show edit update destroy]

  def index
    @listings = policy_scope(Listing)
  end

  def show
    authorize @listing
    @booking = Booking.new
  end

  def new
    @listing = Listing.new
    authorize @listing
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.host = current_user
    authorize @listing
    if @listing.save!
      redirect_to @listing, notice: "Listing was successfully created."
    else
      render :new, status: :unprocessable_entity
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
    redirect_to listings_path, status: :see_other, notice: "Listing was successfully destroyed."
  end

  private

  def set_listing
    @listing = Listing.find(params[:id])
  end

  def listing_params
    params.require(:listing).permit(:title, :description, :address, :country, :price_per_night, :bedroom_count,
                                    :bathroom_count, :bed_count, :guest_count, :house_rules, images: [])
  end
end
