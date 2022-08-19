class User < ApplicationRecord
  has_many :listings, foreign_key: 'host_id', class_name: 'Listing'
  has_many :bookings

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
