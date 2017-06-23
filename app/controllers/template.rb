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
    ap get_data_for_news
    @news = get_data_for_news || get_page_feed_from_api(Koala::Facebook::API.new(page_token, ENV['FACEBOOK_SECRET']))
    render 'news'
  end
  #
  # get :template_events, map: '/:token/events' do
  #
  # end
  #
  # get :template_gallery, map: '/:token/gallery' do
  #   @albums = get_data_for_gallery(Koala::Facebook::API.new(params[:token], ENV['FACEBOOK_SECRET']))
  #   render 'gallery'
  # end

end

# def get_data_for_news(obj)
#   obj.get_connection('me','feed')
# end
#
# def get_data_for_events(obj)
#   obj.get_connection('me','event')
# end
#
# def get_data_for_gallery(obj)
#   obj.get_connection('me','albums')
# end

def get_data_for_home
  facebook_page = FacebookPage.find(id: params['id'])
  facebook_page.about ? facebook_page : nil
end

def get_data_for_news
  facebook_page = FacebookPage.find(id: params['id'])
  page_feed = facebook_page.page_feeds
  page_feed.empty?? nil : page_feed
end

def get_data_for_about
  get_data_for_home
end

def get_data_for_contact
  get_data_for_home
end

def get_data_from_api(obj)
  fields = {fields: 'about,description_html,cover,link,location,website'}
  save_common_page_field (obj.get_object('me',fields))
end

def save_common_page_field(fields)
  FacebookPage.where(id: params[:id]).update(about: fields.dig('about'), description_html: fields.dig('description_html'), link: fields.dig('link'), website: fields.dig('website'), cover_image: fields.dig('cover','source'), country: fields.dig('location','country'), city: fields.dig('location','city'))
  get_data_for_home
end

def get_page_feed_from_api(obj)
  fields = ['created_time','description','name','attachments']
  save_page_feed (obj.get_connection('me','feed',{fields: fields}))
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

def page_token
  FacebookPage.where(id: params['id']).get(:token)
end