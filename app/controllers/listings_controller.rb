class ListingsController < ApplicationController
  before_action :set_listing, only: %i[show edit]

  def index
    @listings = policy_scope(Listing)
  end

  def show
    authorize @listing
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
      render :new
    end
  end

  def edit
    authorize @listing
  end

  def update
    authorize @listing
  end

  private

  def set_listing
    @listing = Listing.find(params[:id])
  end

  def listing_params
    params.require(:listing).permit(:title, :description, :address, :country, :price_per_night, :bedroom_count,
      :bathroom_count, :bed_count, :guest_count, :house_rules)
  end
end
