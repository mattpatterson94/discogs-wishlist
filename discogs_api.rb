require 'discogs'

class DiscogsApi
  MAX_RESULTS_PER_PAGE = 100

  def fetch_by_username(username)
    discogs_api.get_user_wantlist(username, per_page: MAX_RESULTS_PER_PAGE).wants
  end

  def get_release_by_id(id)
    discogs_api.get_release(id)
  end

  private

  def discogs_api
    @discogs_api ||= Discogs::Wrapper.new(discogs_app_name, user_token: discogs_user_token)
  end

  def discogs_app_name
    ENV['DISCOGS_APP_NAME']
  end

  def discogs_user_token
    ENV['DISCOGS_USER_TOKEN']
  end
end
