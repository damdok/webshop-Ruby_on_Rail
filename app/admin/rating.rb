ActiveAdmin.register Rating do
  permit_params :rating, :note

  actions :all, :except => [:new]

  index do
    selectable_column
    id_column
    column :user
    column :product
    column :rating
    column :note
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.semantic_errors
    inputs do
      input :rating
      input :note
    end
    f.actions
  end

end
