Fuitter::App.controllers :session do

  get :auth, '/auth/:provider/callback' do
    ap request.env["omniauth.auth"]
    redirect '/'
  end

end
