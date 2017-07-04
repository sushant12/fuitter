Fuitter::App.controllers :home do

  # the home page
  get :home, map: '/' do
    render 'index'
  end

  get :facebook_pages do
    pages = get_facebook_page_from_db
    # @pages = pages.any? ? pages :  save_pages(get_facebook_pages_from_api(Koala::Facebook::API.new(session[:facebook_token], ENV['FACEBOOK_SECRET'])))
    @pages = pages.any? ? pages : save_pages(Facebook.get_object(session[:facebook_token], 'me?fields=accounts'))
    render 'facebook_pages'
  end
end