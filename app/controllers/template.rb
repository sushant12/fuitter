Fuitter::App.controllers :template do
  layout :template_layout
  get :template_home, map: '/:token/home' do
    @home = get_data_for_home(Koala::Facebook::API.new(params[:token], ENV['FACEBOOK_SECRET']))
    render 'home'
  end

  get :template_about, map: '/:token/about' do
    @about = get_data_for_about(Koala::Facebook::API.new(params[:token], ENV['FACEBOOK_SECRET']))
    render 'about'
  end

  get :template_contact, map: '/:token/contact' do
    @contact = get_data_for_contact(Koala::Facebook::API.new(params[:token], ENV['FACEBOOK_SECRET']))
    render 'contact'
  end

  get :template_news, map: '/:token/news' do
    @news = get_data_for_news(Koala::Facebook::API.new(params[:token], ENV['FACEBOOK_SECRET']))
    render 'news'
  end

  get :template_events, map: '/:token/events' do

  end

  get :template_gallery, map: '/:token/gallery' do
    @albums = get_data_for_gallery(Koala::Facebook::API.new(params[:token], ENV['FACEBOOK_SECRET']))
    render 'gallery'
  end

end

def get_data_for_home(obj)
    fields = {fields: 'name,about,description_html,cover,link,location,website'}
    obj.get_object('me',fields)
end

def get_data_for_about(obj)
  fields = {fields: 'name,about,description_html,cover'}
  obj.get_object('me',fields)
end

def get_data_for_contact(obj)
  fields = {fields: 'name,about,link,location,website'}
  obj.get_object('me', fields)
end

def get_data_for_news(obj)
  obj.get_connection('me','feed')
end

def get_data_for_events(obj)
  obj.get_connection('me','event')
end

def get_data_for_gallery(obj)
  obj.get_connection('me','albums')
end

