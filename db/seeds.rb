# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
PostTag.delete_all
Tag.delete_all
Post.delete_all
User.delete_all


5.times do
  user = User.create!(
    name: Faker::Name.unique.name,
    email: Faker::Internet.unique.email,
    password: 'password'
  )


  post = Post.create!(
    title: Faker::Lorem.sentence,
    content: Faker::Lorem.paragraph,
    user: user,
    published_at: Faker::Time.between(from: 1.year.ago, to: Time.now),
    answers_count: rand(0..10), 
    likes_count: rand(0..20) 
  )
end


tags = []
5.times do
  tags << Tag.create!(name: Faker::Lorem.word)
end


10.times do
  post = Post.create!(
    title: Faker::Lorem.sentence,
    content: Faker::Lorem.paragraph,
    user: User.all.sample,
    published_at: Faker::Time.between(from: 1.year.ago, to: Time.now),
    answers_count: rand(0..10),
    likes_count: rand(0..20)
  )


  post.tags << tags.sample
end


Post.all.each do |post|
  post.tags << tags.sample unless post.tags.present?
end
