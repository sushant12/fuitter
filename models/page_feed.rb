class PageFeed < Sequel::Model
  many_to_one :facebook_page
end
