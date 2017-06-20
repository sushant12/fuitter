Fuitter::App.controllers :session do

  get :auth, '/auth/:provider/callback' do
    auth = request.env['omniauth.auth']
    account = Account.create_or_find_from_omniauth(auth)
    redirect '/'
  end

end
