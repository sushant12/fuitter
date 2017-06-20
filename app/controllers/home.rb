Fuitter::App.controllers :home do

  # the home page
  get :home, map: '/' do
    render 'index'
  end

  get :facebook_pages do
    @pages = list_facebook_pages(Koala::Facebook::API.new(session[:facebook_token], ENV['FACEBOOK_SECRET']))
    render 'facebook_pages'
  end
end

def list_facebook_pages(obj)
  obj.get_connections('me','accounts')
end
