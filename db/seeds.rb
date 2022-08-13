# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "Cleaning Database"
Listing.destroy_all

puts "Creating listings"

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
  listing = Listing.create!(title: title, description: description, country: country, address: address, price_per_night: price_per_night, bedroom_count: bedroom_count, bathroom_count: bathroom_count, bed_count: bed_count, guest_count: guest_count, house_rules: house_rules)

end
