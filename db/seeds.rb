# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Creating 5 Faker users (testX@gmail.com) (PW:Abc123!!")
5.times do |i|
  user =  User.create!(
    first_name: Faker::Name.first_name
    last_name: Faker::Name.last_name
    email: "test#{i}@gmail.com"
    password: "Abc123!!"
    phone_number: Faker::PhoneNumber
  )
puts "Created users test1@gmail.com to test5@gmail.com"
