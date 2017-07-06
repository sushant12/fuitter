class Home < Sequel::Model
  def save_pages(pages)
    pages.map do |page|
      current_account.add_facebook_page(name: page['name'], category: page['category'], token: page['access_token'])
    end
  end
end