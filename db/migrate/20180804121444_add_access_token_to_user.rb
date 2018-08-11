class AddAccessTokenToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :fb_access_token, :string, default: nil
  end
end
