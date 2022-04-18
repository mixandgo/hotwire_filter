# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
1000.times do
  Contact.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    dob: Faker::Date.birthday(min_age: 18, max_age: 65),
    notes: Faker::Lorem.words.join(" ")
  )
end
