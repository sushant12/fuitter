Sequel.migration do
  up do
    create_table :albums do
      primary_key :id
      foreign_key :facebook_page_id, :facebook_pages
      String :name
    end
  end

  down do
    drop_table :albums
  end
end
