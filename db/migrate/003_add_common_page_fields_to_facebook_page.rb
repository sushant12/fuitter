Sequel.migration do
  up do
    alter_table :facebook_pages do
      add_column :description_html, String
      add_column :about, String
      add_column :link, String
      add_column :website, String
      add_column :country, String
      add_column :city, String
      add_column :cover_image, String
    end
  end

  down do
    alter_table :facebook_pages do
      drop_column :description_html
      drop_column :about
      drop_column :link
      drop_column :website
      drop_column :country
      drop_column :city
      drop_column :cover_image
    end
  end
end