class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.boolean :delivered
      t.string :city
      t.string :street
      t.string :address
      t.string :pdf
      t.integer :total
      t.references :user, index: true
      t.references :courier, index: true

      t.timestamps null: false
    end
  end
end
