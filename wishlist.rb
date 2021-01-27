require_relative 'album'
require_relative 'album_variation'

class Wishlist
  include Enumerable

  def add_to_wishlist(item)
    variation = AlbumVariation.new(item)

    album = get_album_from_variation(variation)

    album.add_variation(variation)

    wishlist.sort_by!(&:artist)
  end

  def each(&block)
    wishlist.each(&block)
  end

  private

  def wishlist
    @wishlist ||= []
  end

  def get_album_from_variation(variation)
    album = wishlist.find { |wishlist_album| wishlist_album.id == variation.master_id }

    return create_new_album(variation) if album.nil?

    album
  end

  def create_new_album(variation)
    album = Album.new(variation.master_id)

    wishlist << album

    album
  end
end
