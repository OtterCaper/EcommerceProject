class AddHstToProvinces < ActiveRecord::Migration[6.0]
  def change
    add_column :provinces, :hst, :decimal
  end
end
