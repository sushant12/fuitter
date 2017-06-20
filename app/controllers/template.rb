Fuitter::App.controllers :template do
  layout :template_layout
  get :template_home, map: '/:token/home' do
    @home = get_data_for_home(Koala::Facebook::API.new(params[:token], ENV['FACEBOOK_SECRET']))
    render 'home'
  end

  get :template_about, map: '/:token/about' do

  end

  get :template_contact, map: '/:token/contact' do

  end

  get :template_news, map: '/:token/news' do

  end

  get :template_events, map: '/:token/events' do

  end

  get :template_gallery, map: '/:token/gallery' do

  end

end

def get_data_for_home(obj)
    fields = {fields: 'name,about,description_html,cover,link,location,website'}
    obj.get_object('me',fields)
end