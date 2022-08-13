# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Cleaning Database"

Booking.destroy_all
Listing.destroy_all
User.destroy_all



puts "Creating 10 Faker users (userX@gmail.com) (PW:Abc123!!)"
10.times do |i|
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "user#{i}@gmail.com",
    password: "Abc123!!",
    phone_number: Faker::PhoneNumber.cell_phone
  )
end

puts "Creating Listings"

5.times do
  title = Faker::Address.community
  description = Faker::Lorem.paragraph(sentence_count: 3)
  country = Faker::Address.country
  address = Faker::Address.full_address
  price_per_night = rand(100..700)
  bedroom_count = rand(1..5)
  bathroom_count = rand(1..5)
  guest_count = rand(1..8)
  bed_count = rand(1..5)
  house_rules = Faker::Lorem.paragraph(sentence_count: 2)
  listing = Listing.new(title: title, description: description, country: country, address: address, price_per_night: price_per_night, bedroom_count: bedroom_count, bathroom_count: bathroom_count, bed_count: bed_count, guest_count: guest_count, house_rules: house_rules)
  listing.host = User.all.sample
  listing.save!
end

puts "Creating Bookings"

5.times do
  start_date = Faker::Date.between(from: Date.today - 6.month, to: Date.today + 6.month)
  end_date = start_date + rand(1..5)
  additional_requests = Faker::Lorem.paragraph(sentence_count: 2)
  guest_count = rand(1..8)
  booking = Booking.new(start_date: start_date, end_date: end_date, additional_requests: additional_requests, guest_count: guest_count)
  booking.status = :accepted_by_host if end_date < Date.today
  booking.guest = User.all.sample
  booking.listing = Listing.all.sample
  booking.payment_amount = (end_date - start_date).to_i * booking.listing.price_per_night
  booking.save!
end
