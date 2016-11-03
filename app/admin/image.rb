ActiveAdmin.register Image do
  permit_params :name, :latitude, :longitude, :photo, :post_id

  index do
    selectable_column
    id_column
    column :photo do |row|
      image_tag(row.photo.url(:mini))
    end
    column :name
    column :latitude
    column :longitude
    column :created_at
    actions
  end

  form do |f|
    f.inputs 'Image' do
      f.input :post, as: :select
      f.input :name
      f.input :latitude
      f.input :longitude
      f.input :photo, required: false, as: :file, :hint => f.template.image_tag(f.object.photo.url(:thumb))
    end
    f.actions
  end

  show do |ad|
    attributes_table do
      row :post
      row :name
      row :photo do
        image_tag(ad.photo.url(:thumb))
      end
      row :location do
        query = "q=#{ad.latitude},#{ad.longitude}"
        query += "&zoom=14"
        map_url = "https://www.google.com/maps/embed/v1/place?key=#{ENV['GOOGLE_API_KEY']}&#{query}"
        "<iframe width=\"800\" height=\"450\" frameborder=\"0\" style=\"border:0\" src=\"#{map_url}\" allowfullscreen> </iframe>".html_safe
      end
    end
  end
end
