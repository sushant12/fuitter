module Fuitter
  class App
    module FacebookApiHelper
      def get_facebook_pages_from_api(obj)
        obj.get_connections('me','accounts')
      end

      # TODO: decouple get_albums_from_api
      def get_albums_from_api(obj)
        save_albums(obj.get_connection('me','albums'), obj)
      end

      def get_data_from_api(obj)
        fields = {fields: 'about,description_html,cover,link,location,website'}
        obj.get_object('me',fields)
      end

      def get_page_feed_from_api(obj)
        fields = ['created_time','description','name','attachments']
        obj.get_connection('me','feed',{fields: fields})
      end


    end
    helpers FacebookApiHelper
  end
end
