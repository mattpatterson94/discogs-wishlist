require "limiter"
require "httparty"

require_relative "../parsers/item_price_parser"
require_relative "../data_fetchers/discogs_web"
require_relative "../mixins/threads_per_slice"

class ItemsForSalePopulator
  include ThreadsPerSlice

  def initialize(wishlist:)
    @wishlist = wishlist

    configure_money
  end

  def populate!
    threads_per_slice(wishlist, 2) do |slice, mutex|
      slice.each do |wishlist_album|
        wishlist_album.variations.each do |variation|
          mutex.synchronize do
            variation.add_items_for_sale(find_items_for_sale(variation.id))
          end
        end
      end
    end
  end

  private

  attr_reader :wishlist

  def find_items_for_sale(variation_id)
    raw = discogs_web.sell(variation_id, wishlist.country&.currency&.iso_code)

    ItemPriceParser.new(raw, wishlist.country).parse
  end

  def configure_money
    ISO3166.configuration.enable_currency_extension!
    Money.locale_backend = nil
    Money.default_currency = nil
    Money.rounding_mode = BigDecimal::ROUND_HALF_EVEN
  end

  def discogs_web
    @discogs_web ||= DiscogsWeb.new
  end
end
