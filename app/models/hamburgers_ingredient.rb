class HamburgersIngredient < ApplicationRecord
  belongs_to :hamburger
  belongs_to :ingredient
end
