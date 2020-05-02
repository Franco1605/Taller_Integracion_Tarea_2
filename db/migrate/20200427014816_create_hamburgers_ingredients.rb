class CreateHamburgersIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :hamburgers_ingredients, id: false do |t|
      t.references :hamburger, foreign_key: true
      t.references :ingredient, foreign_key: true
    end
  end
end
