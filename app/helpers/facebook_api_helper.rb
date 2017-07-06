module Fuitter
  class App
    module FacebookApiHelper

      # TODO: decouple get_albums_from_api
      def get_albums_from_api(obj)
        save_albums(obj.get_connection('me','albums'), obj)
      end

      # def get_page_feed_from_api(obj)
      #   fields = ['created_time','description','name','attachments']
      #   obj.get_connection('me','feed',{fields: fields})
      # end


    end
    helpers FacebookApiHelper
  end
end
