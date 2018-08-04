class ApplicationController < ActionController::API
  include Sorcery::Controller

  def test
    "hello world"
  end
end
