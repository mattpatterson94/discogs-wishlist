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

  def year
    @year ||= variations.first&.year
  end

  def lowest_price
    @lowest_price ||= saleable_variations.map(&:lowest_price).compact.minmax.first
  end

  def num_for_sale
    @num_for_sale ||= saleable_variations.sum(&:num_for_sale)
  end

  def lowest_price_localised
    @lowest_price_localised ||= begin
      first = saleable_variations.map(&:lowest_price_localised).compact.minmax.first
      return nil if first.nil?

      first.to_f
    end
  end

  def num_for_sale_localised
    @num_for_sale_localised ||= saleable_variations.sum(&:num_for_sale_localised)
  end

  def to_s
    "#{artist} - #{title} (#{year})"
  end

  def saleable_variations
    @saleable_variations ||= variations.select(&:saleable?)
  end

  def variations
    @variations ||= []
  end
end
