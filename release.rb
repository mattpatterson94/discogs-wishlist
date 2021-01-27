class Release
  def initialize(release)
    @release = release
  end

  def num_for_sale
    release&.num_for_sale
  end

  def lowest_price
    release&.lowest_price
  end

  private

  attr_reader :release
end
