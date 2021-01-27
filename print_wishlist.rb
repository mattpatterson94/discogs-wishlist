require 'terminal-table'

class PrintWishlist
  def initialize(wishlist:)
    @wishlist = wishlist
  end

  def print!
    populate_table

    puts table
  end

  private

  attr_reader :wishlist

  def populate_table
    wishlist.each do |album|
      table.add_row(
        [
          album.title,
          album.artist,
          album.variations.length,
          album.num_for_sale,
          album.lowest_price,
          album.num_for_sale_localised,
          album.lowest_price_localised ? "$#{album.lowest_price_localised}" : ''
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
      'For Sale',
      'Lowest Price',
      'For Sale (Localised)',
      'Lowest Price (Localised)'
    ]
  end
end
