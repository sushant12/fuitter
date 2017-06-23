Sequel.migration do
  up do
    create_table :accounts do
      primary_key :id
      VARCHAR :name
      VARCHAR :email
      VARCHAR :uid
    end
  end

  down do
    drop_table :accounts
  end
end
