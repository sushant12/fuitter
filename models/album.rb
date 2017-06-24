class Album < Sequel::Model
  many_to_one :facebook_page
  one_to_many :pictures
end
