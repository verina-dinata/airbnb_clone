class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(guest: user) # If users can see all restaurants
      # scope.where(user: user) # If users can only see their restaurants
      # scope.where("name LIKE 't%'") # If users can only see restaurants starting with `t`
      # ...
    end
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    record.user == user
    # record: the restaurant passed to the `authorize` method in controller
    # user: the `current_user` signed in with Devise
  end

  def cancel?
    record.pending_host_confirmation?
    #   render json: { message: "Cancel failed. Booking has been accepted by host." }, status: :bad_request
    #   return
    # end
  end
end
