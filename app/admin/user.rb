ActiveAdmin.register User, as: "Normal Users" do
  menu parent: "Users"

  permit_params :email, :name, :phone, :city, :street, :address, :balance, :regular

  actions :all, :except => [:new]

  filter :provider, as: :check_boxes, collection: ["facebook", "twitter", "google"]
  filter :name
  filter :email
  filter :phone
  filter :city
  filter :street
  filter :address
  filter :balance
  filter :regular
  filter :created_at
  filter :updated_at

  index do
    selectable_column
    id_column
    column :provider
    column :name
    column :email
    column :phone
    column :city
    column :street
    column :address
    column :balance
    column :regular
    actions
  end

  form do |f|
    f.semantic_errors
    inputs do
      input :name
      input :email
      input :phone
      input :city
      input :street
      input :address
      input :balance
      input :regular
    end
    f.actions
  end

end
