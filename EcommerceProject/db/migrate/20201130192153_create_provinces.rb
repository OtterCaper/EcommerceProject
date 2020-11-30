class CreateProvinces < ActiveRecord::Migration[6.0]
  def change
    create_table :provinces do |t|
      t.string :name
      t.decimal :GST
      t.decimal :PST

      t.timestamps
    end
  end
end
