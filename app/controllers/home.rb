Fuitter::App.controllers :home do

  # the home page
  get :home, map: '/' do
    render 'index'
  end

  get :facebook_pages do
    pages = get_facebook_page_from_db
    @pages = pages.any? ? pages :  get_facebook_pages_from_api(Koala::Facebook::API.new(session[:facebook_token], ENV['FACEBOOK_SECRET']))
    render 'facebook_pages'
  end
end