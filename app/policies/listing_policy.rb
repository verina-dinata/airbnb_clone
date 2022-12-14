class ListingPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def my_listings?
    true
  end

  def create?
    true
  end

  def show?
    true
  end

  def edit?
    record.host == user
  end

  def update?
    record.host == user
  end

  def destroy?
    record.host == user && record.bookings.empty?
  end
end
