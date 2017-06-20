class Account < Sequel::Model
  def self.create_with_omniauth(auth)
    create do |account|
      account.uid      = auth["uid"]
      account.name    = auth["info"]["name"] if auth["info"]
      account.email    = auth["info"]["email"] if auth["info"]
    end
  end
end
