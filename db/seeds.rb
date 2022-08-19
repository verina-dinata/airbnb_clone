# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "open-uri"

puts "Cleaning Database"

Booking.destroy_all
Listing.destroy_all
User.destroy_all

puts "Creating 3 Faker users (userX@gmail.com) (PW:Abc123!!)"
3.times do |i|
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "user#{i}@gmail.com",
    password: "Abc123!!",
    phone_number: Faker::PhoneNumber.cell_phone
  )
end

puts "Creating Listings"

hotels = {
  'Goodwood Park Hotel' => ['22 Scotts Rd, Singapore 228221', "Goodwood Park Hotel is Singapore`s distinguished heritage hotel and certified as a SG Clean establishment by the Government. Housed in a uniquely designed building dating back to 1900, our 5-star hotel is an endearing pioneer of the Singapore tourism industry. Much of her original beauty has been faithfully restored, with the Grand Tower gazetted a national monument in 1989. "],
  'Park Regis Singapore' => ['23 Merchant Rd, Singapore 058268', "Park Regis Singapore is centrally located within a 3 minutes` walk to Clarke Quay MRT station. Changi International Airport is only 20 minutes` drive away by car or taxi."],
  'Carlton Hotel Singapore' => ['76 Bras Basah Rd, Singapore 189558', "Carlton Hotel offers 940 elegantly designed spacious rooms and is strategically located in the heart of Business District. Warm welcome and cosmopolitan facilities such as Executive and Premier Club Lounge, two restaurants, a patisserie, gym and pool as well as 13 outstanding functions rooms at reach – creating seamless and enjoyable stay for our guests. Every part of the hotel experience is crafted to celebrate modern Singapore and dedicated to the comfort of our guests.
    Strategically located at the heart of Singapore, Carlton is just minutes away from Singapore`s busiest financial and convention centres and the arts, culture and shopping haven such as Raffles Place, Suntec City International Exhibition & Convention Centre, Marina Bay Sands, Esplanade – Theatres on the Bay, Singapore National Museum and major shopping belts in the Marina area as well as at the fringe of Orchard Road."],
  'Parkroyal Collection Marina Bay' => ['6 Raffles Blvd, Singapore 039594', "Explore modern Singapore, with her rich heritage and history just a stone`s throw away from PARKROYAL COLLECTION Marina Bay, a top traveller choice amongst the hotels near Esplanade. Be awed by the iconic skyline as you stroll down Merlion Park to Esplanade, and move to the tunes and performances at the Esplanade Outdoor Theatre."],
  'Hotel Swissotel The Stamford' => ['2 Stamford Rd, Singapore 178882', "Nestled in the heart of Singapore, Swissotel The Stamford is an oasis of vitality and authentic Swiss hospitality. Just a stone's throw from the city's vibrant Marina Bay and historical Civic District, it offers a generous range of inspired restaurants and contemporary guest rooms with private balconies offering unparalleled views."],
  'Marina Bay Sands' => ['710 Bayfront Ave, Singapore 018956', "Live the high life in the breathtaking world of Marina Bay Sands. This is where you can touch, feel, and imagine."],
  'Mandarin Oriental' => ['5 Raffles Ave, Singapore 039797', "Discover contemporary luxury with signature Oriental charm in our meticulously designed hotels, resorts and residences. Reflecting the best of local culture with award-winning dining, wellness and legendary service, we delight our fans with unique experiences that are personal and memorable."],
  'The Fullerton Hotel Singapore' => ['1 Fullerton Square, Singapore 049178', "From the moment you book a stay with us to when you bid farewell and check out, a stay at The Fullerton Hotels and Resorts delivers memorable moments, quietly and with the utmost discreet luxury. "],
  'JW Marriott Hotel Singapore South Beach' => ['30 Beach Road, Singapore 189763', "Balancing historic heritage with contemporary style, JW Marriott Hotel Singapore South Beach offers unrivaled luxury in the downtown Singapore city center, near Marina Bay, the Central Business District and leading attractions including National Stadium & National Gallery. "],
  'Royal Plaza on Scotts Singapore' => ['25 Scotts Rd, Singapore 228220', "Located in Orchard, smack-dab in the middle of Singapore, Royal Plaza on Scotts hotel brings you colourful stays. Expect bright, stylish room design and incredible flavours at our award-winning buffet restaurant Carousel."]
}

hotels.each do |hotel, detail|
  title = hotel
  description = detail[1]
  country = ["Singapore", "Malaysia", "Thailand", "Japan", "Korea", "Singapore", "Australia"].sample
  address = detail[0]
  price_per_night = rand(100..500)
  bedroom_count = rand(1..5)
  bathroom_count = rand(1..5)
  guest_count = rand(1..8)
  bed_count = rand(1..5)
  cleaning_fee = rand(10..20)
  service_fee = rand(10..30)
  house_rules = Faker::Lorem.paragraph(sentence_count: 2)
  listing = Listing.new(title: title, description: description, country: country, address: address, price_per_night: price_per_night, bedroom_count: bedroom_count, bathroom_count: bathroom_count, bed_count: bed_count, guest_count: guest_count, house_rules: house_rules, cleaning_fee: cleaning_fee, service_fee: service_fee)
  listing.host = User.all.sample
  file = URI.open("https://res.cloudinary.com/dlnilayvg/image/upload/v1660383156/dzrfm5xcujthcwy8u64f.jpg")
  listing.images.attach(io: file, filename: "room_interior.jpg", content_type: "image/jpg")
  file2 = URI.open("https://res.cloudinary.com/dlnilayvg/image/upload/v1660567964/uduitc89itibbs2dk6ie.jpg")
  listing.images.attach(io: file2, filename: "bathroom.jpg", content_type: "image/jpg")
  file3 = URI.open("https://www.thespruce.com/thmb/9zdyLzPobCbaJrCfue4JR-xe6Ps=/2075x1167/smart/filters:no_upscale()/living-room-dos-and-donts-2213467-hero-da82a4643bc84d669a0a34f64e60beb1.jpg")
  listing.images.attach(io: file3, filename: "living_room.jpg", content_type: "image/jpg")
  listing.save!
end

puts "Creating Bookings"

15.times do
  start_date = Faker::Date.between(from: Date.today - 1.month, to: Date.today + 6.month)
  end_date = start_date + rand(1..5)
  additional_requests = Faker::Lorem.paragraph(sentence_count: 2)
  guest_count = rand(1..8)
  booking = Booking.new(start_date: start_date, end_date: end_date, additional_requests: additional_requests, guest_count: guest_count)
  if end_date < Date.today
    if end_date.strftime('%d').to_i.even?
      booking.status = :accepted_by_host
    else
      booking.status = :pending_host_confirmation
    end
  end
  booking.listing = Listing.all.sample
  booking.guest = User.all.excluding(booking.listing.host).sample
  booking.payment_amount = (end_date - start_date).to_i * booking.listing.price_per_night
  booking.save!
end
