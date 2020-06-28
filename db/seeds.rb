# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

u = User.create username: "Admin", email: "admin@example.com", password: "123456", admin: true

TopicSection.create([
  { name: "Announcements" },
  { name: "Feedbacks" },
  { name: "FAQ" },
  { name: "Jobs" },
])

def download_remote_file(url)
  response = Net::HTTP.get_response(URI.parse(url))
  StringIO.new(response.body)
end

10.times do
  u = User.create({
    username: Faker::Internet.unique.username,
    email: Faker::Internet.unique.email,
    password: "123456",
  })

  file = download_remote_file("https://api.adorable.io/avatars/285/#{u.email}")
  u.avatar.attach(io: file, filename: "user_avatar_#{u.id}.png", content_type: "image/png")
  sleep(5)
end

10.times do
  t = Topic.create(
    title: Faker::Book.unique.title,
    topic_section: TopicSection.order("RANDOM()").first
  )

  rand(1..15).times do
    Post.create({
      topic: t,
      user: User.order("RANDOM()").first,
      content: Faker::Books::Lovecraft.unique.paragraph,
    })
    sleep(2)
  end
end

User.first.subscribed_topics << Topic.order("RANDOM()").limit(5)
