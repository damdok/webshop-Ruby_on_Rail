ActiveAdmin.register Courier do
  permit_params :name, :email

  filter :email
  filter :name
  filter :created_at
  filter :updated_at

end
