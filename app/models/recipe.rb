class Recipe < ApplicationRecord
  belongs_to :user
  has_many :ingredient_recipe
  has_many :ingredient, through: :ingredient_recipe
  validates :category, :meal_type, presence: true
end
