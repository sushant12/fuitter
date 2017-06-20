# Helper methods defined here can be accessed in any controller or view in the application

module Fuitter
  class App
    # module HomeHelper
    #   # def simple_helper_method
    #   # ...
    #   # end
    # end
    module BaseHelper
      def current_account
        @current_account ||= Account.find(id: session['account_id']) if session[:account_id]
      end
    end
    helpers BaseHelper
  end
end
