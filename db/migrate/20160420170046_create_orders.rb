class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :quantity
      t.references :invoice, index: true
      t.references :product, index: true

      t.timestamps null: false
    end
  end
end
