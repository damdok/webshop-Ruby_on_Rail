class AddUsersIndex < ActiveRecord::Migration
  def change
    add_index :users, :provider
    add_index :users, :uid
    add_index :users, [:provider, :uid], unique: true
  end
end
