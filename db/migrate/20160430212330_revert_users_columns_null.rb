class RevertUsersColumnsNull < ActiveRecord::Migration
  def change
    change_column_null :users, :image_url, true
    change_column_null :users, :name, true
  end
end
