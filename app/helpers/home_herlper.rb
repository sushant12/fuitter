module Fuitter
  class App
    module HomeHelper
      def get_facebook_pages_from_api(obj)
        pages = obj.get_connections('me','accounts')
        save_pages(pages)
      end

      def save_pages(pages)
        pages.map do |page|
          current_account.add_facebook_page(name: page['name'], category: page['category'], token: page['access_token'])
        end
      end

      def get_facebook_page_from_db
        current_account.facebook_pages
      end
    end
    helpers HomeHelper
  end
end
