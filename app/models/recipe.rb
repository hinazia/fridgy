require "open-uri"
class Recipe < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :ingredient_recipes, dependent: :destroy
  has_many :ingredients, through: :ingredient_recipes, dependent: :destroy
  validates :category, :meal_type, presence: true

  include PgSearch::Model
    pg_search_scope :search_by_title_and_content,
    against: [ :title, :content ],
     using: {
      tsearch: { prefix: true }
  }

  after_save if: -> { saved_change_to_title? || saved_change_to_content? } do
   set_photo
  end

  private

  def set_photo
    client = OpenAI::Client.new
    response = client.images.generate(parameters: {
     prompt: "A recipe image of #{title}", size: "256x256"
    })

    url = response["data"][0]["url"]
    file =  URI.open(url)

    photo.purge if photo.attached?
    photo.attach(io: file, filename: "ai_generated_image.jpg", content_type: "image/png")
    return photo
  end

end
