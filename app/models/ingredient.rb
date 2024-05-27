class Ingredient < ApplicationRecord
  belongs_to :user
  has_many :ingredient_recipe
  has_many :recipe, through: :ingredient_recipe
  validates :name, :amount, :measurement, presence: true
end
