class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.string :category
      t.string :meal_type
      t.string :content
      t.boolean :favourite
      t.boolean :public_share
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
