ActiveAdmin.register Post do
  permit_params :title, :content, :author_id

  index do
    selectable_column
    id_column
    column :title
    column :created_at
    actions
  end

  form do |f|
    f.inputs 'Post' do
      f.input :author, as: :select
      f.input :title
      f.input :content
      f.input :posted_at, as: :datepicker
    end
    f.actions
  end
end
