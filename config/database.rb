Sequel::Model.plugin(:schema)
Sequel::Model.raise_on_save_failure = false # Do not throw exceptions on failure
Sequel::Model.db = case Padrino.env
                     when :development then Sequel.connect("postgres://#{ENV['DB_USERNAME']}:#{ENV['DB_PASSWORD']}@localhost/fuitter_development", :loggers => [logger])
                     when :production  then Sequel.connect('postgres://tirhygorqgfdii:87a87ddad0d65c97f0ea1aa9cc06f5104403e9294122d3b1da9f6ca66ba9bace@ec2-174-129-224-33.compute-1.amazonaws.com:5432/d66titt21mbg2u',  :loggers => [logger])
                     when :test        then Sequel.connect("postgres://#{ENV['DB_USERNAME']}:#{ENV['DB_PASSWORD']}@localhost/fuitter_test",        :loggers => [logger])
                   end