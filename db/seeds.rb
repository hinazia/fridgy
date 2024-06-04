# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
User.destroy_all
Ingredient.destroy_all
Recipe.destroy_all

p 'creating user'
user = User.create!(email: 'boris@lewago.org', password: "123456")
p ' creating ingredients'
Ingredient.create!(name: 'eggs', measurement: 'unit', amount: 5, user: user)
Ingredient.create!(name: 'corn', measurement: 'g', amount: 500, user: user)
Ingredient.create!(name: 'beef', measurement: 'g', amount: 500, user: user)

p 'creating recipes'
Recipe.create!(category: "Breakfast", meal_type: "American", content: "Scrambled eggs with spinach", favourite: true, public_share: true, user_id: user.id, title: "Spinach Scramble")
Recipe.create!(category: "Lunch", meal_type: "Vegetarian", content: "Quinoa salad with roasted vegetables", favourite: true, public_share: true, user_id: user.id, title: "Roasted Veggie Quinoa Salad")
