class AddNotNull < ActiveRecord::Migration
  def change
    change_column_null :users, :provider, false
    change_column_null :users, :uid, false
    change_column_null :users, :image_url, false
    change_column_null :users, :name, false
    change_column_null :categories, :name, false
    change_column_null :vendors, :name, false
    change_column_null :vendors, :email, false
    change_column_null :couriers, :name, false
    change_column_null :couriers, :email, false
    change_column_null :products, :price, false
    change_column_null :products, :name, false
    change_column_null :products, :stock, false
    change_column_null :products, :wholesale_price, false
    change_column_null :invoices, :delivered, false
    change_column_null :invoices, :total, false
    change_column_null :orders, :quantity, false
    change_column_null :carts, :quantity, false
    change_column_null :admin_orders, :quantity, false
    change_column_null :ratings, :rating, false
  end
end
