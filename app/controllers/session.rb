Fuitter::App.controllers :session do

  get :auth, '/auth/:provider/callback' do
    auth = request.env['omniauth.auth']
    account = Account.find(uid: auth['uid']) || Account.create_with_omniauth(auth)
    redirect '/'
  end

end
