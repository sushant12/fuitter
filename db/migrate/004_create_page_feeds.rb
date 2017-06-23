Sequel.migration do
  up do
    create_table :page_feeds do
      primary_key :id
      foreign_key :facebook_page_id, :facebook_pages
      column :created_time, 'timestamp'
      String :description
      VARCHAR :name
      VARCHAR :cover_image
      VARCHAR :attachment_url
    end
  end

  down do
    drop_table :page_feeds
  end
end
