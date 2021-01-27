require_relative 'release'

class AlbumVariation
  def initialize(variation)
    @variation = variation
    @localised_sale_information = []
  end

  def add_release_information(release)
    @release_information = Release.new(release)
  end

  def saleable?
    @release_information || @localised_sale_information&.length&.positive?
  end

  def add_localised_sale_information(localised_sale_information = [])
    @localised_sale_information = localised_sale_information.compact.sort_by { |info| info[:price] }
  end

  def id
    variation.id
  end

  def url
    variation.basic_information.resource_url
  end

  def master_id
    variation.basic_information.master_id
  end

  def num_for_sale
    return 0 unless @release_information

    @release_information.num_for_sale
  end

  def lowest_price
    @release_information&.lowest_price
  end

  def num_for_sale_localised
    @localised_sale_information.length
  end

  def lowest_price_localised
    (@localised_sale_information.first || {})[:price]
  end

  def shipping_localised
    (@localised_sale_information.first || {})[:shipping]
  end

  def title
    variation.basic_information.title
  end

  def artist
    variation.basic_information.artists.map(&:name)&.join(', ')
  end

  def year
    variation.basic_information.year
  end

  private

  attr_reader :variation
end
