class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :image_url
      t.string :email
      t.string :name
      t.string :phone
      t.string :city
      t.string :street
      t.string :address
      t.integer :balance
      t.boolean :regular

      t.timestamps null: false
    end
  end
end
