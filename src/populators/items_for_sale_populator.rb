require 'limiter'
require 'httparty'

require_relative '../parsers/item_price_parser'
require_relative '../data_fetchers/discogs_web'
require_relative '../mixins/threads_per_slice'

class ItemsForSalePopulator
  include ThreadsPerSlice

  def initialize(wishlist:, country:)
    @wishlist = wishlist
    @country = country
  end

  def populate!
    threads_per_slice(wishlist, 2) do |slice|
      slice.each do |wishlist_album|
        wishlist_album.variations.each do |variation|
          variation.add_items_for_sale(
            find_items_for_sale(variation.id)
          )
        end
      end
    end
  end

  private

  attr_reader :wishlist, :country

  def find_items_for_sale(variation_id)
    raw = discogs_web.sell(variation_id, country.currency.iso_code)

    ItemPriceParser.new(raw, country).parse
  end

  def discogs_web
    @discogs_web ||= DiscogsWeb.new
  end
end
