require 'rails_helper'

RSpec.describe OauthsController, type: :controller do

  context 'oauth login redirect' do
    it 'should GET Facebook login path' do
      get :oauth, params: {provider: 'facebook'}
      expect(response).to be_a_redirect
      expect(response).to redirect_to("https://www.facebook.com/v2.9/dialog/oauth?client_id=#{ENV['FACEBOOK_KEY']}&display=page&redirect_uri=http%3A%2F%2Flocalhost%3A3000%2Foauth%2Fcallback%3Fprovider%3Dfacebook&response_type=code&scope=email%2Cmanage_pages&state")
    end
  end

end