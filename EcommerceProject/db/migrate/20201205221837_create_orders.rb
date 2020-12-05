class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :status, null: false, foreign_key: true
      t.decimal :GST
      t.decimal :PST
      t.decimal :HST
      t.decimal :amount_before_tax
      t.string :shipping_address
      t.string :pi

      t.timestamps
    end
  end
end
