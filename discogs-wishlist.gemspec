# frozen_string_literal: true

require_relative "lib/discogs/wishlist/version"

Gem::Specification.new do |spec|
  spec.name          = "discogs-wishlist"
  spec.version       = Discogs::Wishlist::VERSION
  spec.authors       = ["Matt Patterson"]
  spec.email         = ["hey@mattdoesdev.com"]

  spec.summary       = "A CLI tool to generate a discogs user wishlist"
  spec.description   = "This gem uses the discogs wrapper gem to fetch user wishlist information and then does some custom scraping to get items for sale in your selected country."
  spec.homepage      = "https://mattdoesdev.com"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/mattpatterson94/discogs-wishlist"
  spec.metadata["changelog_uri"] = "https://github.com/mattpatterson94/discogs-wishlist"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "thor", "~> 1.1.0"
  spec.add_dependency "countries", "~> 3.0.1"
  spec.add_dependency "discogs-wrapper", "~> 2.5.1"
  spec.add_dependency "httparty", "~> 0.18.1"
  spec.add_dependency "monetize", "~> 1.10.0"
  spec.add_dependency "money", "~> 6.14.0"
  spec.add_dependency "nokogiri", "~> 1.11.1"
  spec.add_dependency "ruby-limiter", "~> 1.1.0"
  spec.add_dependency "terminal-table", "~> 2.0.0"

  spec.add_development_dependency "pry"
  spec.add_development_dependency "standard"
end
