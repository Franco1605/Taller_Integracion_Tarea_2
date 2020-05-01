class Ingredient < ApplicationRecord
  validates :nombre, presence: true
  validates :descripcion, presence: true
  has_many :hamburgers_ingredients, dependent: :delete_all
  has_many :hamburgers, :through => :hamburgers_ingredients
end
