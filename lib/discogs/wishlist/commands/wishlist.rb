require "countries"

require_relative "../populators/wishlist_populator"
require_relative "../populators/items_for_sale_populator"
require_relative "../models/wishlist"
require_relative "../printers/wishlist_printer"
require_relative "../mixins/output_suppressor"

module Commands
  class Wishlist
    include OutputSuppressor

    def initialize(username:, for_sale:, country_code:)
      @username = username
      @for_sale = for_sale
      @country_code = country_code
    end

    def perform
      suppress_output do
        populate_wishlist
        populate_items_for_sale if show_for_sale?
      end

      print_wishlist
    end

    private

    attr_reader :username, :for_sale, :country_code

    def print_wishlist
      WishlistPrinter.new(wishlist: wishlist, show_for_sale: show_for_sale?).print!
    end

    def populate_wishlist
      WishlistPopulator.new(wishlist: wishlist).populate!
    end

    def populate_items_for_sale
      ItemsForSalePopulator.new(wishlist: wishlist).populate!
    end

    def wishlist
      @wishlist ||= ::Wishlist.new(username: username, country: country)
    end

    def show_for_sale?
      for_sale && !!country
    end

    def country
      @country || begin
        return nil unless country_code

        ISO3166::Country.new(country_code)
      end
    end
  end
end
