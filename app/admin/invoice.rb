ActiveAdmin.register Invoice do
  permit_params :delivered, :courier_id

  actions :all, :except => [:new]

  filter :user
  filter :courier
  filter :products
  filter :delivered
  filter :city
  filter :street
  filter :address
  filter :total
  filter :created_at
  filter :updated_at

  index do
    selectable_column
    id_column
    column :user
    column :courier
    column :delivered
    column :total
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.semantic_errors
    inputs do
      input :delivered
      input :courier
    end
    f.actions
  end

end
