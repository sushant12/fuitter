class Account < Sequel::Model
  def self.create_or_find_from_omniauth(auth)
    find(uid: auth['uid']) || create do |account|
      account.uid = auth["uid"]
      account.name = auth["info"]["name"] if auth["info"]
      account.email = auth["info"]["email"] if auth["info"]
    end
  end
end
