class CreateIngredients < ActiveRecord::Migration[7.1]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.string :measurement
      t.float :amount
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
