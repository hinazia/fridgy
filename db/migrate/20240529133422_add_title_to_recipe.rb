class AddTitleToRecipe < ActiveRecord::Migration[7.1]
  def change
    add_column :recipes, :title, :string
  end
end
