require "terminal-table"

class WishlistPrinter
  def initialize(wishlist:, show_for_sale:)
    @wishlist = wishlist
    @show_for_sale = show_for_sale
  end

  def print!
    populate_table

    puts table
  end

  private

  attr_reader :wishlist, :show_for_sale

  def populate_table
    wishlist.each do |album|
      table.add_row(album_columns(album))
    end
  end

  def table
    @table ||= Terminal::Table.new(title: title, headings: headings)
  end

  def title
    "Wishlist"
  end

  def album_columns(album)
    columns = [
      album.title,
      album.artist,
      album.variations.length
    ]

    return columns unless show_for_sale

    columns + [
      album.items_for_sale_count,
      album.lowest_price_cost,
      album.lowest_price_shipping
    ]
  end

  def headings
    common_headings = ["Title", "Artist", "Variations"]

    return common_headings unless show_for_sale

    country_code = wishlist.country ? "(#{wishlist.country.alpha2})" : ""

    common_headings + [
      "For Sale #{country_code}",
      "Lowest Price #{country_code}",
      "Shipping #{country_code}"
    ]
  end
end
