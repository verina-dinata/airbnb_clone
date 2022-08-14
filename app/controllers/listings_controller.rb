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

  def edit
    authorize @listing
  end

  private

  def set_listing
    @listing = Listing.find(params[:id])
  end
end
