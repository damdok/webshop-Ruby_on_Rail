ActiveAdmin.register Order, as: "User Orders" do
  menu parent: "Orders"

  actions :all, :except => [:new, :edit, :destroy]

  batch_action :destroy, false

  filter :product
  filter :user
  filter :quantity
  filter :created_at
  filter :updated_at

  index do
    id_column
    column :product
    column :user
    column :quantity
    column :created_at
    column :updated_at
    actions
  end

end
