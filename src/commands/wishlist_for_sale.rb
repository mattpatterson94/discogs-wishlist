require_relative '../populators/wishlist_populator'
require_relative '../populators/items_for_sale_populator'
require_relative '../models/wishlist'
require_relative '../printers/wishlist_for_sale_printer'
require_relative '../mixins/output_suppressor'

module Commands
  class WishlistForSale
    include OutputSuppressor

    def initialize(username:, country:)
      @username = username
      @country = country
    end

    def perform
      # suppress_output do
        populate_wishlist
        populate_items_for_sale
      # end

      print_wishlist
    end

    private

    attr_reader :username, :country

    def print_wishlist
      WishlistForSalePrinter.new(wishlist: wishlist, country: country).print!
    end

    def populate_wishlist
      WishlistPopulator.new(wishlist: wishlist, username: username).populate!
    end

    def populate_items_for_sale
      ItemsForSalePopulator.new(wishlist: wishlist, country: country).populate!
    end

    def wishlist
      @wishlist ||= Wishlist.new
    end
  end
end
