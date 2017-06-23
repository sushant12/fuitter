Fuitter::App.controllers :home do

  # the home page
  get :home, map: '/' do
    render 'index'
  end

  get :facebook_pages do
    if pages?
      @pages = get_facebook_page_from_db
    else
      @pages = get_facebook_pages_from_api(Koala::Facebook::API.new(session[:facebook_token], ENV['FACEBOOK_SECRET']))
    end
    render 'facebook_pages'
  end
end

def get_facebook_pages_from_api(obj)
  pages = obj.get_connections('me','accounts')
  save_pages(pages)
end

def save_pages(pages)
  pages.map do |page|
    current_account.add_facebook_page(name: page['name'], category: page['category'], token: page['access_token'])
  end
end

def get_facebook_page_from_db
  current_account.facebook_pages
end

def pages?
  get_facebook_page_from_db.empty? ? false : true
end