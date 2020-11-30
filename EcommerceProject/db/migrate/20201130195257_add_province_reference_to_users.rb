class AddProvinceReferenceToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :Province, null: false, default: 1, foreign_key: true
  end
end
