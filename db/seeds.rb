# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# for catagoriy 

# db/seeds.rb

# db/seeds.rb

categories = [
  { name: "Technology", description: "Latest trends in software, hardware, and digital innovation." },
  { name: "Health & Wellness", description: "Tips for a healthier body and mind." },
  { name: "Travel", description: "Experiences and guides from around the world." },
  { name: "Food & Recipes", description: "Cooking inspiration, recipes, and reviews." },
  { name: "Education & Learning", description: "Resources, tutorials, and learning strategies." },
  { name: "Lifestyle", description: "Everyday living, fashion, and culture." },
  { name: "Business & Finance", description: "Entrepreneurship, markets, and personal finance." },
  { name: "Entertainment", description: "Movies, music, TV, and pop culture." },
  { name: "Science & Nature", description: "Discoveries, environment, and natural wonders." },
  { name: "Personal Development", description: "Self-improvement, productivity, and growth." }
]

categories.each do |attrs|
  Category.find_or_create_by!(slug: attrs[:name].parameterize) do |category|
    category.name = attrs[:name]
    category.description = attrs[:description]
    category.active = true
  end
end

puts "✅ Seeded #{Category.count} categories with slugs."

