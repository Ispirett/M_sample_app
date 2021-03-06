# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

 User.create!(name:  "Isaac Browne",
              email: "nicketa@gmail.com",
              password:              "12345678",
              password_confirmation: "12345678",
              admin:true,
              activated:true,
              activated_at: Time.zone.now
             )

20.times do |n|
  name  = Faker::Name.name
  email = "tom-#{n+1}@gmail.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated:true,
               activated_at: Time.zone.now)
end
