Fuitter::App.controllers :home do

  get :home, map: '/' do
    render 'index'
  end

end
