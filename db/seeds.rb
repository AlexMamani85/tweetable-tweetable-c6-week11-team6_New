require "faker"

puts "Start seeding data"

Like.destroy_all
Tweet.destroy_all
User.destroy_all

puts "Start seeding users"


10.times do |i|
  avatar_url = Faker::LoremFlickr.image(size: "48x48", search_terms: ["logo"])
  user = User.new(
    email:Faker::Internet.unique.email(domain: "example"),
    username:Faker::Twitter.unique.user[:screen_name],
    name: Faker::Twitter.unique.user[:name],
    password: "qwerty",
    password_confirmation: "qwerty"
  )
  user.avatar.attach(io: URI.open(avatar_url), filename: "image#{i + 1}")
  user.save
end

puts "Start seeding tweets"

5.times do
  tweet = Tweet.create(
    body: Faker::Twitter.status[:text],
    user: User.all.sample
  )
end

45.times do
  Tweet.create(
    body: Faker::Twitter.status[:text],
    user: User.all.sample,
    replied_to: Tweet.all.sample
  )
end

100.times do
  Like.create(
    tweet: Tweet.all.sample,
    user: User.all.sample
  )
end

user=User.create(email: 'admin@example.com', username:'admin', name:'adminnistrador', password:'qwerty',password_confirmation:'qwerty', role: 'admin')

puts "Finished seeding"
p "="*50
p User.first.email
p User.second.email
p User.third.email
p User.fourth.email
p "="*50

