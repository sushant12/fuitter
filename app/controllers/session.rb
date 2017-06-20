Fuitter::App.controllers :session do

  get :auth, map: '/auth/:provider/callback' do
    auth = request.env['omniauth.auth']
    account = Account.create_or_find_from_omniauth(auth)
    session[:account_id] = account.id
    redirect '/'
  end

  get :destroy, map: 'destroy' do
    session[:account_id] = nil
    redirect '/'
  end

end
