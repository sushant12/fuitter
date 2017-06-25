Fuitter::App.controllers :session do

  get :auth, map: '/auth/:provider/callback' do
    auth =  request.env['omniauth.auth']
    account = Account.create_or_find_from_omniauth(auth)
    store_val_in_session(account, auth)
    redirect '/home/facebook_pages'
  end

  get :destroy, map: 'destroy' do
    session[:account_id] = nil
    redirect '/'
  end

end