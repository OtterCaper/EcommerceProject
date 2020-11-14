class Product < ApplicationRecord
  belongs_to :category

  has_one_attached :image

  validates :name, uniqueness: true
  validates :name, :price, :description, :category, :stock, presence: true
end
