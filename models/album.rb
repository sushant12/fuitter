class Album < Sequel::Model
  many_to_one :facebook_page
end
