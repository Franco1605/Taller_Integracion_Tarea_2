class Hamburger < ApplicationRecord
  validates :nombre, presence: true
  validates :precio, presence: true
  validates :descripcion, presence: true
  validates :imagen, presence: true
  has_many :hamburgers_ingredients, dependent: :delete_all
  has_many :ingredients, :through => :hamburgers_ingredients
end
