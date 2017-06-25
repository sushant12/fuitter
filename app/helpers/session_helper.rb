module Fuitter
  class App
    module SessionHelper
      def store_val_in_session(account, auth)
        session[:account_id] = account.id
        session[:facebook_token] = auth['credentials']['token']
      end
    end
    helpers SessionHelper
  end
end
