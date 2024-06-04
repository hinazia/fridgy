class Recipe < ApplicationRecord
  belongs_to :user
  has_many :ingredient_recipes, dependent: :destroy
  has_many :ingredients, through: :ingredient_recipes, dependent: :destroy
  validates :category, :meal_type, presence: true

  include PgSearch::Model
    pg_search_scope :search_by_title_and_content,
    against: [ :title, :content ],
     using: {
      tsearch: { prefix: true } 
  }
end
