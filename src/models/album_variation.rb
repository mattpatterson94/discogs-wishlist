class AlbumVariation
  def initialize(variation)
    @variation = variation
  end

  def saleable?
    return false unless @items_for_sale

    @items_for_sale.length.positive?
  end

  def add_items_for_sale(items_for_sale)
    @items_for_sale = items_for_sale.compact.sort_by { |info| info[:price] }
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

  def items_for_sale_count
    @items_for_sale.length
  end

  def lowest_price
    @lowest_price ||= @items_for_sale.first
  end

  def title
    variation.basic_information.title
  end

  def artist
    variation.basic_information.artists.map(&:name)&.join(', ')
  end

  private

  attr_reader :variation
end
