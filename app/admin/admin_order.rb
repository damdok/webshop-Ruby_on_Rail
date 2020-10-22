ActiveAdmin.register AdminOrder do
  menu parent: "Orders"

  permit_params :admin_user_id, :product_id, :quantity

  index do
    selectable_column
    id_column
    column :product
    column :admin_user, label: "Ordered by"
    column :quantity
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.semantic_errors
    inputs do
      if f.object.new_record?
        f.input :admin_user, :as => :select, collection: [current_admin_user], include_blank: false do
          current_admin_user.id
        end
      end
      input :product
      input :quantity
    end
    f.actions
  end

end
