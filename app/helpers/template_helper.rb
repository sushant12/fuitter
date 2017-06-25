# Helper methods defined here can be accessed in any controller or view in the application

module Fuitter
  class App
    module TemplateHelper
      def get_data_for_home
        facebook_page = FacebookPage.find(id: params['id'])
        facebook_page.about ? facebook_page : nil
      end

      def get_data_for_news
        facebook_page = FacebookPage.find(id: params['id'])
        page_feed = facebook_page.page_feeds
        page_feed.empty?? nil : page_feed
      end

      def get_data_for_about
        get_data_for_home
      end

      def get_data_for_contact
        get_data_for_home
      end

      def get_data_for_gallery
        facebook_page = FacebookPage.find(id: params[:id])
        albums = facebook_page.albums
        albums.empty? ? nil : albums
      end

# common data op

      def get_data_from_api(obj)
        fields = {fields: 'about,description_html,cover,link,location,website'}
        save_common_page_field (obj.get_object('me',fields))
      end

      def save_common_page_field(fields)
        FacebookPage.where(id: params[:id]).update(about: fields.dig('about'), description_html: fields.dig('description_html'), link: fields.dig('link'), website: fields.dig('website'), cover_image: fields.dig('cover','source'), country: fields.dig('location','country'), city: fields.dig('location','city'))
        get_data_for_home
      end

# page feed op

      def get_page_feed_from_api(obj)
        fields = ['created_time','description','name','attachments']
        save_page_feed (obj.get_connection('me','feed',{fields: fields}))
      end

      def save_page_feed(feeds)
        facebook_page = FacebookPage.find(id:params['id'])
        feeds.each do |feed|
          # check if attachment exist
          cover_image =  feed.dig('attachments','data')[0].dig('media','image','src') if feed.dig('attachments','data')
          attachment_url = feed.dig('attachments','data')[0].dig('url') if feed.dig('attachments','data')

          facebook_page.add_page_feed(created_time: feed.dig('created_time'), description: feed.dig('description'),name: feed.dig('name'),cover_image: cover_image,attachment_url: attachment_url)
        end
        get_data_for_news
      end

# album op

      def get_albums_from_api(obj)
        save_albums(obj.get_connection('me','albums'), obj)
      end

      def save_albums(albums, obj)
        facebook_page = FacebookPage.find(id: params[:id])
        albums.each do |album|
          id = facebook_page.add_album(name: album['name']).id
          find_large_image_url(obj,album,id)
        end
        get_data_for_gallery
      end

      def find_large_image_url(obj,album,id)
        fields = {fields: 'webp_images'}
        photos =  obj.get_connection(album['id'],'photos',fields)
        photos.each do |v|
          # find the sum of height and width of each image collection to return the image with higher resolution
          sum = v['webp_images'].map { |v| v['height'] + v['width']}
          index = sum.each.with_index.max[1]
          img = v['webp_images'][index]['source']
          save_photos(id,img)
        end
      end

      def save_photos(id,img)
        album = Album.find(id: id)
        album.add_picture(url: img)
      end

      def list_photos
        album = Album.find(id: params[:album_id])
        album.pictures
      end

      def page_token
        FacebookPage.where(id: params['id']).get(:token)
      end
    end

    helpers TemplateHelper
  end
end
