class CreateAdminOrders < ActiveRecord::Migration
  def change
    create_table :admin_orders do |t|
      t.integer :quantity
      t.references :admin_user, index: true
      t.references :product, index: true

      t.timestamps null: false
    end
  end
end
