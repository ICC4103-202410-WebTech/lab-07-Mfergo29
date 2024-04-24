# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Limpiar la base de datos
PostTag.delete_all
Tag.delete_all
Post.delete_all
User.delete_all

# Crear usuarios
5.times do
  user = User.create!(
    name: Faker::Name.unique.name,
    email: Faker::Internet.unique.email,
    password: 'password'
  )

  # Crear al menos una publicación para cada usuario
  post = Post.create!(
    title: Faker::Lorem.sentence,
    content: Faker::Lorem.paragraph,
    user: user,
    published_at: Faker::Time.between(from: 1.year.ago, to: Time.now),
    answers_count: rand(0..10), # Respuestas aleatorias entre 0 y 10
    likes_count: rand(0..20)    # Likes aleatorios entre 0 y 20
  )
end

# Crear etiquetas
tags = []
5.times do
  tags << Tag.create!(name: Faker::Lorem.word)
end

# Crear publicaciones y asociarlas con usuarios y etiquetas
10.times do
  post = Post.create!(
    title: Faker::Lorem.sentence,
    content: Faker::Lorem.paragraph,
    user: User.all.sample,
    published_at: Faker::Time.between(from: 1.year.ago, to: Time.now),
    answers_count: rand(0..10), # Respuestas aleatorias entre 0 y 10
    likes_count: rand(0..20)    # Likes aleatorios entre 0 y 20
  )

  # Asociar al menos una etiqueta a cada publicación
  post.tags << tags.sample
end

# Asociar las etiquetas restantes a las publicaciones existentes
Post.all.each do |post|
  post.tags << tags.sample unless post.tags.present?
end
