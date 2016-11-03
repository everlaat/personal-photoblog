ActiveAdmin.register Author do
  permit_params [:name, :email]

  index do
    selectable_column
    id_column
    column :name
    column :email
    actions
  end

  filter :email

end
