class FacebookPage < Sequel::Model
  many_to_one :account
  one_to_many :page_feeds
  one_to_many :albums
end
