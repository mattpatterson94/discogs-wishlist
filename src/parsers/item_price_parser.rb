require 'nokogiri'
require 'monetize'

class ItemPriceParser
  def initialize(html, country)
    @html = html
    @country = country
  end

  def parse
    return [] unless rows.length.positive?

    rows.map do |row|
      price = row.search('.item_price .price').text.gsub(/[^\d\.]+/, '')
      shipping = row.search('.item_shipping').first.text.gsub(/[^\d\.]+/, '')

      return nil if price.nil? || shipping.nil?

      {
        price: Monetize.parse(price, country.currency.iso_code),
        shipping: Monetize.parse(shipping, country.currency.iso_code)
      }
    end.compact
  end

  private

  attr_reader :html, :country

  def rows
    @rows ||= parsed_html.search('.mpitems tbody tr')
  end

  def parsed_html
    @parsed_html ||= Nokogiri::HTML(html.body)
  end
end
