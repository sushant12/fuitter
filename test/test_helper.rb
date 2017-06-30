PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)

require File.expand_path(File.dirname(__FILE__) + "/../config/boot")

require 'minitest/autorun'
require 'rack/test'

def app
  ##
  # You can handle all padrino applications using instead:
    Padrino.application
  # Pergola.tap { |app|  }
end