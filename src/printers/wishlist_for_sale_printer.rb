require 'terminal-table'

class WishlistForSalePrinter
  def initialize(wishlist:, country:)
    @wishlist = wishlist
    @country = country
  end

  def print!
    populate_table

    puts table
  end

  private

  attr_reader :wishlist, :country

  def populate_table
    wishlist.each do |album|
      table.add_row(
        [
          album.title,
          album.artist,
          album.variations.length,
          album.items_for_sale_count,
          album.lowest_price_cost,
          album.lowest_price_shipping
        ]
      )
    end
  end

  def table
    @table ||= Terminal::Table.new(title: title, headings: headings)
  end

  def title
    'Wishlist'
  end

  def headings
    [
      'Title',
      'Artist',
      'Variations',
      "For Sale (#{country.alpha2})",
      "Lowest Price (#{country.alpha2})",
      "Shipping (#{country.alpha2})"
    ]
  end
end
