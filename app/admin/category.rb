ActiveAdmin.register Category do
  permit_params :name, :parent_id

  filter :parent
  filter :children
  filter :name
  filter :created_at
  filter :updated_at

  index do
    selectable_column
    column :id
    column :name
    column :parent
    column :created_at
    column :updated_at
    actions
  end

end
