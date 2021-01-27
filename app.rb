require_relative 'populate_wishlist'
require_relative 'populate_variation_release_information'
require_relative 'populate_localised_sales'
require_relative 'wishlist'
require_relative 'print_wishlist'

class App
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
    PrintWishlist.new(wishlist: wishlist).print!
  end

  def populate_wishlist
    PopulateWishlist.new(wishlist: wishlist, username: username).populate!
  end

  def populate_releases_information
    PopulateVariationReleaseInformation.new(wishlist: wishlist).populate!
  end

  def populate_localised_sales
    PopulateLocalisedSales.new(wishlist: wishlist).populate!
  end

  def wishlist
    @wishlist ||= Wishlist.new
  end

  def username
    'mattpatterson'
  end

  def suppress_output
    original_stdout = $stdout.clone
    original_stderr = $stderr.clone
    $stderr.reopen File.new('/dev/null', 'w')
    $stdout.reopen File.new('/dev/null', 'w')
    yield
  ensure
    $stdout.reopen original_stdout
    $stderr.reopen original_stderr
  end
end

App.run
