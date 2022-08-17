Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :listings
  get "my/listings", to: "listings#my_listings", as: :my_listings
  resources :bookings, except: %i[delete destroy]
  post "bookings/:id/cancel", to: "bookings#cancel", as: :cancel_booking
end
