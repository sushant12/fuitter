Fuitter::App.controllers :page do
  layout :page_layout

  get :page_home, map: '/:id/home' do
    @home = get_data_for_home || save_common_page_field(get_data_from_api(Koala::Facebook::API.new(page_token, ENV['FACEBOOK_SECRET'])))
    render 'home'
  end

  get :page_about, map: '/:id/about' do
    @about = get_data_for_about || save_common_page_field(get_data_from_api(Koala::Facebook::API.new(page_token, ENV['FACEBOOK_SECRET'])))
    render 'about'
  end

  get :page_contact, map: '/:id/contact' do
    @contact = get_data_for_contact || save_common_page_field(get_data_from_api(Koala::Facebook::API.new(page_token, ENV['FACEBOOK_SECRET'])))
    render 'contact'
  end

  get :page_news, map: '/:id/news' do
    @news = get_data_for_news || save_page_feed(get_page_feed_from_api(Koala::Facebook::API.new(page_token, ENV['FACEBOOK_SECRET'])))
    render 'news'
  end

  # get :template_events, map: '/:token/events' do
  # end

  get :page_gallery, map: '/:id/gallery' do
    @albums = get_data_for_gallery || get_albums_from_api(Koala::Facebook::API.new(page_token, ENV['FACEBOOK_SECRET']))
    render 'gallery'
  end

  get :page_photos, map: '/:id/gallery/:album_id/photos' do
    @photos =  list_photos
    render 'photos'
  end

  private

  def save_common_page_field(fields)
    FacebookPage.where(id: params[:id]).update(about: fields.dig('about'), description_html: fields.dig('description_html'), link: fields.dig('link'), website: fields.dig('website'), cover_image: fields.dig('cover','source'), country: fields.dig('location','country'), city: fields.dig('location','city'))
  end

  def save_page_feed(feeds)
    facebook_page = FacebookPage.find(id:params['id'])
    feeds.each do |feed|
      # check if attachment exist
      cover_image =  feed.dig('attachments','data')[0].dig('media','image','src') if feed.dig('attachments','data')
      attachment_url = feed.dig('attachments','data')[0].dig('url') if feed.dig('attachments','data')

      facebook_page.add_page_feed(created_time: feed.dig('created_time'), description: feed.dig('description'),name: feed.dig('name'),cover_image: cover_image,attachment_url: attachment_url)
    end
  end

end

# def get_data_for_events(obj)
#   obj.get_connection('me','event')
# end
