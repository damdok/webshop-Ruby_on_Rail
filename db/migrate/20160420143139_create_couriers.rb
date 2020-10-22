class CreateCouriers < ActiveRecord::Migration
  def change
    create_table :couriers do |t|
      t.string :email
      t.string :name

      t.timestamps null: false
    end
  end
end
