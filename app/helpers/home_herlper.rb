module Fuitter
  class App
    module HomeHelper

      def get_facebook_page_from_db
        current_account.facebook_pages
      end

    end
    helpers HomeHelper
  end
end
