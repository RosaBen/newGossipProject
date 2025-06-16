require "faker"
require "open-uri"
# rails db:drop db:create db:migrate db:seed

puts "🔄 Nettoyage des données..."
Gossip.delete_all
User.delete_all
City.delete_all
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='cities'")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='users'")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='gossips'")

avatar_path = Rails.root.join('db', 'seeds', "assets", 'avatar.png')

puts "🏙️ Ajout des villes"
10.times do
  City.create!(
    city_name: Faker::Address.city,
    zip_code: Faker::Number.number(digits: 5)
  )
end

puts "👤 Ajout des utilisateurs"
User.create!(pseudo: "rosa", email: "test@test.com", bio: Faker::Lorem.paragraph(sentence_count: 5), password: "password", password_confirmation: "password", city: City.create!(city_name: "Paris", zip_code: "75000"))
10.times do
  password = "password"
  user=User.create!(
    pseudo: Faker::FunnyName.name,
    email: Faker::Internet.unique.email,
    bio: Faker::Lorem.paragraph(sentence_count: 5),
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
    title: Faker::Lorem.sentence(word_count: 3),
    content: Faker::Lorem.paragraph(sentence_count: 4),
    user: User.all.sample
  )
  gossip.media.attach(
    io: file,
    filename: "image.jpg",
    content_type: "image/jpeg"
  )
end

puts "✅ Seeds terminés !"
