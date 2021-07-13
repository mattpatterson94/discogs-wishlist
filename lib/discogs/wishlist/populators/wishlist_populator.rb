require_relative "../data_fetchers/discogs_api"

class WishlistPopulator
  def initialize(wishlist:)
    @wishlist = wishlist
  end

  def populate!
    wantlist = discogs_api.fetch_by_username(wishlist.username)

    wantlist.each do |wantlist_item|
      wishlist.add_to_wishlist(wantlist_item)
    end
  end

  private

  attr_reader :wishlist

  def discogs_api
    @discogs_api ||= DiscogsApi.new
  end
end
