require "faker"
require "open-uri"
# rails db:drop db:create db:migrate db:seed

puts "🔄 Nettoyage des données..."
GossipTag.delete_all
Comment.delete_all
Like.delete_all
Tag.delete_all
Gossip.delete_all
User.delete_all
City.delete_all
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='cities'")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='users'")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='gossips'")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='comments'")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='likes'")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='tags'")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='gossip_tags'")

avatar_path = Rails.root.join('db', 'seeds', "assets", 'avatar.png')

puts "🏙️ Ajout des villes"
10.times do
  City.create!(
    city_name: Faker::Address.city,
    zip_code: Faker::Number.number(digits: 5)
  )
end

puts "👤 Ajout des utilisateurs"
User.create!(pseudo: "rosa", email: "test@test.com", bio: Faker::Hipster.paragraphs(number: 2), password: "password", password_confirmation: "password", city: City.create!(city_name: "Paris", zip_code: "75000"))
10.times do
  password = "password"
  user=User.create!(
    pseudo: Faker::Name.first_name,
    email: Faker::Internet.unique.email,
    bio: Faker::Hipster.paragraphs(number: 2),
    password: password,
    password_confirmation: password,
    city: City.all.sample,
  )
  user.avatar.attach(
    io: File.open(avatar_path),
    filename: "avatar.png",
    content_type: "image/png"
  )
end

puts "🔤 Contenu ajouté"
10.times do
  url = "https://picsum.photos/200"
  file = URI.open(url)
  gossip = Gossip.create!(
    title: Faker::Company.buzzword,
    content: Faker::Lorem.paragraphs(number: 1),
    user: User.all.sample
  )
  gossip.media.attach(
    io: file,
    filename: "image.jpg",
    content_type: "image/jpeg"
  )
end

puts "💬 Ajout des commentaires"
10.times do
  Comment.create!(
    content: Faker::GreekPhilosophers.quote,
    user: User.all.sample,
    gossip: Gossip.all.sample,
  )
end
puts " 🏷️ Ajouts des tags"
10.times do
  tag = Tag.create!(name: Faker::Emotion.noun)
  GossipTag.create!(
    gossip: Gossip.all.sample,
    tag: tag
  )
end

puts "📎  lier les tags au gossip"
10.times do
  gossip = Gossip.all.sample
  tag = Tag.all.sample
  GossipTag.create!(
    gossip: gossip,
    tag: tag
  )
end
puts "👍 Ajout des likes"
10.times do
  Like.create!(
    user: User.all.sample,
    gossip: Gossip.all.sample
  )
end

puts "✅ Seeds terminés !"
