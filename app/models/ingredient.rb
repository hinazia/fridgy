class Ingredient < ApplicationRecord
  belongs_to :user
  has_many :ingredient_recipe, dependent: :destroy
  has_many :recipe, through: :ingredient_recipe, dependent: :destroy
  validates :name, :amount, :measurement, presence: true

  MEASUREMENTS = ['ml', 'l', 'g', 'kg', 'tsp', 'tbsp', 'piece']
  MEAL_TYPES = ['Breakfast', 'Lunch', 'Dinner']
  CATEGORIES = ['Balkan', 'French', 'Indian', 'Italian', 'Japanese', 'Korean', 'Latin American', 'Mexican', 'Pakistani', 'Spanish', 'Thai', 'Vietnamese']

end
