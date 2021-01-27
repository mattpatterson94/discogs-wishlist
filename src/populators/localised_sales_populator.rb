require 'limiter'
require 'httparty'
require 'nokogiri'

require_relative '../data_fetchers/discogs_web'

class LocalisedSalesPopulator
  def initialize(wishlist:)
    @wishlist = wishlist
  end

  def populate!
    wishlist.each_slice(2) do |slice|
      thread = Thread.new do
        slice.each do |wishlist_album|
          wishlist_album.variations.each do |variation|
            localised_sales = find_localised_sales(variation.id)

            next unless localised_sales.length.positive?

            variation.add_localised_sale_information(localised_sales)
          end
        end
      end

      threads << thread
    end

    threads.each(&:join)
  end

  private

  attr_reader :wishlist

  def threads
    @threads ||= []
  end

  def find_localised_sales(variation_id)
    page = Nokogiri::HTML(discogs_web.sell(variation_id))

    rows = page.search('.mpitems tbody tr')

    return [] unless rows.length.positive?

    filtered_rows = rows.select do |row|
      seller_info = row.search('td.seller_info li')
      shipping_info = seller_info.find { |info| info.text.include? 'Ships From:' }

      shipping_info.text.include? location
    end

    return [] unless filtered_rows.length.positive?

    filtered_rows.map do |row|
      price = row.search('.item_price .price').text.gsub(/[^\d\.]+/, '')
      shipping = row.search('.item_shipping').first.text.gsub(/[^\d\.]+/, '')

      {
        price: !price.empty? ? BigDecimal(price) : 0,
        shipping: !shipping.empty? ? BigDecimal(shipping) : 0
      }
    end
  end

  def location
    'Australia'
  end

  def discogs_web
    @discogs_web ||= DiscogsWeb.new
  end
end
