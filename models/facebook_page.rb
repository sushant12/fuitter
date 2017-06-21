class FacebookPage < Sequel::Model
  many_to_one :account

  def self.save(pages)
    # ap @facebook_pages
    pages.each do |page|
      create do |fb_page|
        fb_page.name = page['name']
        fb_page.account_id = session[:account_id]
      end
    end
  end
end
