require_relative 'discogs_api'

class PopulateWishlist
  def initialize(wishlist:, username:)
    @wishlist = wishlist
    @username = username
  end

  def populate!
    wantlist = discogs_api.fetch_by_username(username)

    wantlist.each do |wantlist_item|
      wishlist.add_to_wishlist(wantlist_item)
    end
  end

  private

  attr_reader :wishlist, :username

  def discogs_api
    @discogs_api ||= DiscogsApi.new
  end
end
