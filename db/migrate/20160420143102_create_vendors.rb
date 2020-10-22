class CreateVendors < ActiveRecord::Migration
  def change
    create_table :vendors do |t|
      t.string :email
      t.string :name

      t.timestamps null: false
    end
  end
end
