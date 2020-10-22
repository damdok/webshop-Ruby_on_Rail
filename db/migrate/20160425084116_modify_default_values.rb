class ModifyDefaultValues < ActiveRecord::Migration
  def up
    change_column :users, :balance, :integer, :default => 0
    change_column :users, :regular, :boolean, :default => false
  end
end
