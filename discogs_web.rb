require 'discogs'

class DiscogsWeb
  include HTTParty
  base_uri 'discogs.com'

  def sell(release_id)
    self.class.get("/sell/release/#{release_id}")
  end
end
