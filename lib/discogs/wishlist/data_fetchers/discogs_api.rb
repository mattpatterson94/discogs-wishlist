require "discogs"

class DiscogsApi
  MAX_RESULTS_PER_PAGE = 100

  def fetch_authenticated_user_identity
    discogs_api.get_identity
  end

  def fetch_by_username(username)
    discogs_api.get_user_wantlist(username, per_page: MAX_RESULTS_PER_PAGE).wants
  end

  def get_release_by_id(id, currency)
    discogs_api.get_release(id, currency)
  end

  private

  def discogs_api
    @discogs_api ||= Discogs::Wrapper.new(discogs_app_name, user_token: discogs_user_token)
  end

  def discogs_app_name
    ENV["DISCOGS_APP_NAME"] || "discogs-wishlist"
  end

  def discogs_user_token
    ENV["DISCOGS_USER_TOKEN"]
  end
end
