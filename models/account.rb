class Account < Sequel::Model
  one_to_many :facebook_pages

  def self.create_or_find_from_omniauth(auth)
    find(uid: auth['uid']) || create do |account|
      account.uid = auth["uid"]
      if auth["info"]
        account.name = auth["info"]["name"]
        account.email = auth["info"]["email"]
      end
    end
  end

end
