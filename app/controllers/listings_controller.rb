class ListingsController < ApplicationController
  def index
    @listings = policy_scope(Listing)
  end
end
