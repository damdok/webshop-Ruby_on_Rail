class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :rating
      t.text :note
      t.references :product, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
