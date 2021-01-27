require 'limiter'

require_relative 'discogs_api'

class PopulateVariationReleaseInformation
  extend Limiter::Mixin

  limit_method :find_release, rate: 40

  def initialize(wishlist:)
    @wishlist = wishlist
  end

  def populate!
    wishlist.each_slice(1) do |slice|
      thread = Thread.new do
        slice.each do |wishlist_album|
          wishlist_album.variations.each do |variation|
            release = find_release(variation.id)

            variation.add_release_information(release)
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

  def find_release(variation_id)
    discogs_api.get_release_by_id(variation_id)
  end

  def discogs_api
    @discogs_api ||= DiscogsApi.new
  end
end
