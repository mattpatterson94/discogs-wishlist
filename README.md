# Discogs::Wishlist

This tool is used to generate your Discogs Wishlist in your terminal. It also has options which will pull sale information for your wishlist items, and can be filtered to a country of your choice.

## Installation

```ruby
gem 'discogs-wishlist'
```

## Usage

### Generate Wishlist

wishlist-for-sale --username mattpatterson

#### With Sale Information

wishlist-for-sale --username mattpatterson --for-sale --country-code AU

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/discogs-wishlist. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/discogs-wishlist/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Discogs::Wishlist project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/discogs-wishlist/blob/master/CODE_OF_CONDUCT.md).
