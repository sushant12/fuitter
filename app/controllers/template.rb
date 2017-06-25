Fuitter::App.controllers :template do
  layout :template_layout

  get :template_home, map: '/:id/home' do
    @home = get_data_for_home || get_data_from_api(Koala::Facebook::API.new(page_token, ENV['FACEBOOK_SECRET']))
    render 'home'
  end

  get :template_about, map: '/:id/about' do
    @about = get_data_for_about || get_data_from_api(Koala::Facebook::API.new(page_token, ENV['FACEBOOK_SECRET']))
    render 'about'
  end

  get :template_contact, map: '/:id/contact' do
    @contact = get_data_for_contact || get_data_from_api(Koala::Facebook::API.new(page_token, ENV['FACEBOOK_SECRET']))
    render 'contact'
  end

  get :template_news, map: '/:id/news' do
    @news = get_data_for_news || get_page_feed_from_api(Koala::Facebook::API.new(page_token, ENV['FACEBOOK_SECRET']))
    render 'news'
  end

  # get :template_events, map: '/:token/events' do
  # end

  get :template_gallery, map: '/:id/gallery' do
    @albums = get_data_for_gallery || get_albums_from_api(Koala::Facebook::API.new(page_token, ENV['FACEBOOK_SECRET']))
    render 'gallery'
  end

  get :template_photos, map: '/:id/gallery/:album_id/photos' do
    @photos =  list_photos
    render 'photos'
  end

end

# def get_data_for_events(obj)
#   obj.get_connection('me','event')
# end
