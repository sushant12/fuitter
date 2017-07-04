module Fuitter
  class App
    module HomeHelper

      def get_facebook_page_from_db
        current_account.facebook_pages
      end

      def save_pages(pages)
        pages['accounts']['data'].map do |page|
          current_account.add_facebook_page(name: page['name'], category: page['category'], token: page['access_token'])
        end
		  end

    end
    helpers HomeHelper
  end
end
