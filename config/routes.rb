Rails.application.routes.draw do
  get 'oauths/oauth'
  get 'oauths/callback'
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback" # for use with Github, Facebook
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
  root to: "application#test"
end
