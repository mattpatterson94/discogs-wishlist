require "discogs"

class DiscogsWeb
  include HTTParty
  base_uri "discogs.com"

  def sell(release_id, currency)
    self.class.get("/sell/release/#{release_id}?currency=#{currency}")
  end
end
