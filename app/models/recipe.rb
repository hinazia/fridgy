class Recipe < ApplicationRecord
  belongs_to :user
  has_many :ingredient_recipes
  has_many :ingredients, through: :ingredient_recipes
  validates :category, :meal_type, presence: true
end
