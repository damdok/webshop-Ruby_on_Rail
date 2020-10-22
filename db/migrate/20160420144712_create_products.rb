class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :price
      t.float :discount
      t.string :name
      t.integer :stock
      t.text :description
      t.integer :wholesale_price
      t.string :image_url
      t.references :category, index: true
      t.references :vendor, index: true

      t.timestamps null: false
    end
  end
end
