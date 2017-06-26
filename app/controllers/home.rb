Fuitter::App.controllers :home do

  # the home page
  get :home, map: '/' do
    render 'index'
  end

  get :facebook_pages do
    pages = get_facebook_page_from_db
    @pages = pages.any? ? pages :  save_pages(get_facebook_pages_from_api(Koala::Facebook::API.new(session[:facebook_token], ENV['FACEBOOK_SECRET'])))
    render 'facebook_pages'
  end

  private

  def save_pages(pages)
    pages.map do |page|
      current_account.add_facebook_page(name: page['name'], category: page['category'], token: page['access_token'])
    end
  end
end