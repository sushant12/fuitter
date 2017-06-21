Sequel::Model.plugin(:schema)
Sequel::Model.raise_on_save_failure = false # Do not throw exceptions on failure
Sequel::Model.db = case Padrino.env
                     when :development then Sequel.connect("postgres://#{ENV['DB_USERNAME']}:#{ENV['DB_PASSWORD']}@localhost/fuitter_development", :loggers => [logger])
                     when :production  then Sequel.connect(ENV['HEROKU_POSTGRESQL_SILVER_URL'],  :loggers => [logger])
                     when :test        then Sequel.connect("postgres://#{ENV['DB_USERNAME']}:#{ENV['DB_PASSWORD']}@localhost/fuitter_test",        :loggers => [logger])
                   end