class ModifyCartsDefault < ActiveRecord::Migration
  def up
    change_column :carts, :quantity, :integer, :default => 0
  end
end
