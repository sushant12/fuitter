Sequel.migration do
  up do
    create_table :pictures do
      primary_key :id
      foreign_key :album_id, :albums
      String :url
    end
  end

  down do
    drop_table :pictures
  end
end
