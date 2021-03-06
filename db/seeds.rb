# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Users
User.create!(name: "Example User",
             email: "example@railstutorial.org",
             password:                  "123456",
             password_confirmation:     "123456",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
               email: email,
               password:                password,
               password_confirmation:   password,
               activated: true,
               activated_at: Time.zone.now)
end

# Microposts
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end

# Following relationships
users = User.all
user = users.first
# 49 -> 2 + 49 = 51
following = users[2..50]
# 38 -> 3 + 38 = 41
followers = users[3..40]
# first user follows users 3 - 51
following.each { |followed| user.follow(followed) }
# users 4 - 41 follow the first user back
followers.each { |follower| follower.follow(user) }
