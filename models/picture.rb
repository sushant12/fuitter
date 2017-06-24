class Picture < Sequel::Model
  many_to_one :album
end
