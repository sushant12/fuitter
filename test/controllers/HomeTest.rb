require File.expand_path(File.dirname(__FILE__) + '/../test_helper.rb')


# OUTER_APP = Rack::Builder.parse_file("config.ru").first


class HomeTest < Minitest::Test
	include Rack::Test::Methods

	# def app
 #    	Fuitter.tap { |app| }
	# end
	def test_should_show_fb_login
		get('/')
	p last_response
		
		assert_equal 'FB Login', last_response.body
	end
end