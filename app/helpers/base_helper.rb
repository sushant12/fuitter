module Fuitter
  class App
    module BaseHelper
      def current_account
        @current_account ||= Account.find(id: session['account_id']) if session[:account_id]
      end
    end
    helpers BaseHelper
  end
end
