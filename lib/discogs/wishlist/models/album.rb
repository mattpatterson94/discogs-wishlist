class Album
  attr_reader :id

  def initialize(id)
    @id = id
  end

  def add_variation(variation)
    variations << variation
  end

  def title
    @title ||= variations.first&.title
  end

  def artist
    @artist ||= variations.first&.artist
  end

  def lowest_price
    @lowest_price ||= begin
      return nil unless items_for_sale_count.positive?

      saleable_variations.map(&:lowest_price).min_by { |price| price[:price] }
    end
  end

  def lowest_price_cost
    return nil if lowest_price.nil?

    @lowest_price_cost ||= lowest_price[:price].format
  end

  def lowest_price_shipping
    return nil if lowest_price.nil?

    @lowest_price_shipping ||= lowest_price[:shipping].format
  end

  def items_for_sale_count
    @items_for_sale_count ||= saleable_variations.sum(&:items_for_sale_count)
  end

  def saleable_variations
    @saleable_variations ||= variations.select(&:saleable?)
  end

  def variations
    @variations ||= []
  end
end
