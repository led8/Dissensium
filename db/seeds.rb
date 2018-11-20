# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Vote.destroy_all
Solution.destroy_all
Issue.destroy_all
User.destroy_all

puts '*' * 30
puts 'Creating 10 fake users...'

8.times do
   User.create(
    username: Faker::Movies::StarWars.character,
    email: Faker::Internet.email,
    created_at: Time.current,
    password: "123456"
  )
 end

puts '*' * 30
puts 'Creating random issue for users...'

User.all.each do |user|
  rand(1..2).times do
    Issue.create(
             title: Faker::Movies::StarWars.planet,
             user: user,
            )
  end
end

puts '*' * 30
puts 'Creating random solutions for issues...'

Issue.all.each do |issue|
  rand(4..6).times do
    Solution.create(
                 content: Faker::TvShows::HowIMetYourMother.quote,
                 user: User.all.sample,
                 issue: issue,
                )

  end
end

puts '*' * 30
puts 'Creating random solutions for issues...'
Issue.all.each do |issue|
  number_of_votes = issue.solutions.count - 1
  issue.solutions.each do |solution|
    i = 0
    number_of_votes.times do
      Vote.create(
              rating: rand(1..5),
              user: User.all[i],
              solution: solution,
            )
      i += 1
    end
  end
end

