Sequel.migration do
  up do
    create_table :facebook_pages do
      primary_key :id
      foreign_key :account_id, :accounts
      String :name
      String :token
      String :category
    end
  end

  down do
    drop_table :facebook_pages
  end
end
