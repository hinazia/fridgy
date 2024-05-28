class Ingredient < ApplicationRecord
  belongs_to :user
  has_many :ingredient_recipe
  has_many :recipe, through: :ingredient_recipe
  validates :name, :amount, :measurement, presence: true

  MEASUREMENTS = ['ml', 'g', 'kg', 'l', 'mg', 'tsp', 'tbsp', 'cup', 'pint', 'quart', 'gallon', 'oz', 'lb', 'inch', 'cm', 'mm', 'm', 'ft', 'yard', 'sq ft', 'sq m', 'sq km', 'sq mile', 'acre', 'hectare', 'sq yard', 'sq inch', 'sq cm', 'sq mm', 'sq m', 'sq ft', 'sq km', 'sq mile', 'acre', 'hectare', 'sq yard', 'sq inch', 'sq cm', 'sq mm', 'sq m', 'sq ft', 'sq km', 'sq mile', 'acre', 'hectare', 'sq yard', 'sq inch', 'sq cm', 'sq mm', 'sq m', 'sq ft', 'sq km', 'sq mile', 'acre', 'hectare', 'sq yard', 'sq inch', 'sq cm', 'sq mm', 'sq m', 'sq ft', 'sq km', 'sq mile', 'acre', 'hectare', 'sq yard', 'sq inch', 'sq cm', 'sq mm', 'sq m', 'sq ft', 'sq km', 'sq mile', 'acre', 'hectare', 'sq yard', 'sq inch', 'sq cm', 'sq mm', 'sq m', 'sq ft', 'sq km', 'sq mile', 'acre', 'hectare', 'sq yard', 'sq inch', 'sq cm', 'sq mm', 'sq m', 'sq ft', 'sq km', 'sq mile', 'acre', 'hectare', 'sq yard', 'sq inch', 'sq cm', 'sq mm', 'sq m', 'sq ft', 'sq km', 'sq mile', 'acre', 'hectare', 'sq yard', 'sq inch', 'sq cm', 'sq mm', 'sq m', 'sq ft', 'sq km', 'sq mile', 'acre', 'hectare', 'sq yard', 'sq inch', 'sq cm', 'sq mm', 'sq m', 'sq ft', 'sq km', 'sq mile', 'acre', 'hectare', 'sq yard', 'sq inch', 'sq cm', 'sq mm', 'sq m', 'sq ft', 'sq km',]
end
