class Ingredient < ApplicationRecord
  belongs_to :user
  has_many :ingredient_recipe
  has_many :recipe, through: :ingredient_recipe
  validates :name, :amount, :measurement, presence: true

  MEASUREMENTS = ['ml', 'g', 'kg', 'l', 'mg', 'tsp', 'tbsp', 'cup', 'pint', 'quart', 'gallon', 'oz', 'lb']
  MEAL_TYPES = ['Breakfast', 'Lunch', 'Dinner']
  CATEGORIES = ['Asian', 'Balkan', 'Japanise', 'Pakistani', 'Brazilian']

end
