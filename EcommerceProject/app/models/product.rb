class Product < ApplicationRecord
  belongs_to :category

  has_one_attached :image

  validates :name, uniqueness: true
  validates :name, :price, :description, :category, :stock, presence: true

  def self.search(search, search_attribute)
    if search
      products = if search_attribute
                   case search_attribute.to_i
                   when 1
                     Product.where(['name LIKE ?', "%#{sanitize_sql_like(search)}%"])
                   when 2
                     if search.length != 0
                       Product.joins(:category).where(['categories.name LIKE "Adaption" AND products.name LIKE ?', "%#{sanitize_sql_like(search)}%"])
                     else
                       Product.joins(:category).where(['categories.name LIKE "Adaption"'])
                     end
                   when 3
                     if search.length != 0
                       Product.joins(:category).where(['categories.name LIKE "Emission" AND products.name LIKE ?', "%#{sanitize_sql_like(search)}%"])
                     else
                       Product.joins(:category).where(['categories.name LIKE "Emission"'])
                     end
                   when 4
                     if search.length != 0
                       Product.joins(:category).where(['categories.name LIKE "Enhancement" AND products.name LIKE ?', "%#{sanitize_sql_like(search)}%"])
                     else
                       Product.joins(:category).where(['categories.name LIKE "Enhancement"'])
                     end
                   when 5
                     if search.length != 0
                       Product.joins(:category).where(['categories.name LIKE "Manipulation" AND products.name LIKE ?', "%#{sanitize_sql_like(search)}%"])
                     else
                       Product.joins(:category).where(['categories.name LIKE "Manipulation"'])
                     end
                   else
                     Product.all
                   end
                 else
                   Product.all
                 end
      products
    else
      Product.all
    end
  end
end
