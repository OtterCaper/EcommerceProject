class Product < ApplicationRecord
  belongs_to :category

  has_one_attached :image

  validates :name, uniqueness: true
  validates :name, :price, :description, :category, :stock, presence: true

  def self.search(search, search_attribute, sale_attribute, new_attribute)
    if search
      products = if search_attribute
                   products = Product.joins(:category)
                   case search_attribute.to_i
                   when 2
                     products.where(['categories.name LIKE "Adaption"'])
                   when 3
                     products.where(['categories.name LIKE "Emission"'])
                   when 4
                     products.where(['categories.name LIKE "Enhancement"'])
                   when 5
                     products.where(['categories.name LIKE "Manipulation"'])
                   else
                     Product.all
                   end
                 else
                   Product.all
                 end
      products = products.where('products.name LIKE ?', "%#{sanitize_sql_like(search)}%") if search.to_s != ''

      products = products.where(sale: true) if sale_attribute.to_i == 1

      products = products.where('created_at > ?', 3.days.ago) if new_attribute.to_i == 1

      products

    else
      Product.all
    end
  end
end
