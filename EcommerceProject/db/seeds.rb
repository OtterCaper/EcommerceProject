Product.delete_all
Category.delete_all
AdminUser.delete_all

NUMBER_OF_PRODUCTS = 25
MAX_STOCK = 100

Category.create(name: 'Adaption')
Category.create(name: 'Emission')
Category.create(name: 'Enhancement')
Category.create(name: 'Manipulation')

Category.all.each do |category|
  NUMBER_OF_PRODUCTS.times do
    name = Faker::Superhero.name + "'s " + Faker::Superhero.unique.power
    sale = Faker::Boolean.boolean(true_ratio: 0.2)
    discount = 0
    discount = Faker::Number.between(from: 0.05, to: 0.75).round(2) if sale

    category.products.create(
      name: name,
      price: Faker::Commerce.price(range: 10..300),
      description: 'This ' + Faker::Commerce.material + ' ' + name + ' is great for uses in ' + Faker::Company.bs,
      sale: sale,
      discount: discount,
      stock: Faker::Number.between(from: 1, to: 500)
    )
  end
end

if Rails.env.development?
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
end
