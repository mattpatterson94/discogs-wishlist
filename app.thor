require_relative 'src/commands/wishlist_for_sale'
require 'countries'

ISO3166.configuration.enable_currency_extension!
Money.locale_backend = nil
Money.rounding_mode = BigDecimal::ROUND_HALF_EVEN

class App < Thor
  desc 'wishlist-for-sale', 'Wishlist Items for Sale'
  method_option :username, aliases: '-u', desc: 'Discogs Username'
  method_option :country_code, aliases: '-c', desc: 'Country Code (used for localised sales)'
  def wishlist_for_sale
    Commands::WishlistForSale.new(
      username: options[:username],
      country: ISO3166::Country.new(options[:country_code])
    ).perform
  end
end
