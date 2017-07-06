Fuitter::App.controllers :page do
  layout :page_layout

  before do
    # check if common data is present
    # else save the data
    get_data_for_home ? '':  save_common_page_field(Facebook.get_object(page_token, 'me?fields=about,description_html,cover,link,location,website'))
  end

  get :page_home, map: '/:id/home' do
    @home = get_data_for_home
    render 'home'
  end

  get :page_about, map: '/:id/about' do
    @about = get_data_for_about
    render 'about'
  end

  get :page_contact, map: '/:id/contact' do
    @contact = get_data_for_contact
    render 'contact'
  end

  get :page_news, map: '/:id/news' do
    @news = get_data_for_news || save_page_feed(Facebook.get_object(page_token, 'me?fields=feed{created_time,description,name,attachments}'))
    render 'news'
  end

  get :page_gallery, map: '/:id/gallery' do
    @albums = get_data_for_gallery || get_albums_from_api(Koala::Facebook::API.new(page_token, ENV['FACEBOOK_SECRET']))
    render 'gallery'
  end

  get :page_photos, map: '/:id/gallery/:album_id/photos' do
    @photos =  list_photos
    render 'photos'
  end

end
