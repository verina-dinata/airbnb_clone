Rails.application.routes.draw do
  devise_for :users
  root to: "listings#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :listings
  get "my/listings", to: "listings#my_listings", as: :my_listings
  resources :bookings, except: %i[delete destroy]
  post "bookings/:id/cancel", to: "bookings#cancel", as: :cancel_booking
  post "bookings/:id/host_cancel", to: "bookings#host_cancel", as: :host_cancel_booking
  post "bookings/:id/host_accept", to: "bookings#host_accept", as: :host_accept_booking
end
