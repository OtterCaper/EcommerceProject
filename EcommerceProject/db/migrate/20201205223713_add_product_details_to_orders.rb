class AddProductDetailsToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :product_details, :text
  end
end
