# frozen_string_literal: true

require "thor"
require_relative "wishlist/version"
require_relative "wishlist/commands/wishlist"

module Discogs
  module Wishlist
    class Error < StandardError; end

    class CLI < Thor
      package_name "discogs-wishlist"

      desc "print USERNAME", "Generate Wishlist Table"
      method_option :for_sale, aliases: "-s", type: :boolean, default: false, desc: "Show For Sale Information"
      method_option :country_code, aliases: "-c", default: "US", desc: "Country Code (to display sale items)"
      def print(username)
        Commands::Wishlist.new(
          username: username,
          for_sale: options[:for_sale],
          country_code: options[:country_code]
        ).perform
      end

      def self.exit_on_failure?
        true
      end
    end
  end
end
