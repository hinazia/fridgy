class Recipe < ApplicationRecord
  belongs_to :user
  has_many :ingredient_recipes
  has_many :ingredients, through: :ingredient_recipes
  validates :category, :meal_type, presence: true

  include PgSearch::Model
    pg_search_scope :search_by_title_and_content,
    against: [ :title, :content ],
     using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
  }
end
