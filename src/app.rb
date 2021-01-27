require_relative 'populators/wishlist_populator'
require_relative 'populators/variation_release_information_populator'
require_relative 'populators/localised_sales_populator'
require_relative 'models/wishlist'
require_relative 'printers/wishlist_for_sale_printer'
require_relative 'mixins/output_suppressor'

require 'pry'

class App
  include OutputSuppressor

  class << self
    def run
      new.run
    end
  end

  def run
    suppress_output do
      populate_wishlist
      populate_releases_information
      populate_localised_sales
    end

    print_wishlist
  end

  private

  def print_wishlist
    WishlistForSalePrinter.new(wishlist: wishlist).print!
  end

  def populate_wishlist
    WishlistPopulator.new(wishlist: wishlist, username: username).populate!
  end

  def populate_releases_information
    VariationReleaseInformationPopulator.new(wishlist: wishlist).populate!
  end

  def populate_localised_sales
    LocalisedSalesPopulator.new(wishlist: wishlist).populate!
  end

  def wishlist
    @wishlist ||= Wishlist.new
  end

  def username
    'mattpatterson'
  end
end

App.run
