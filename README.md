# DroidAdbs
`DroidAdbs` is simple `adb` commands for Android.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'droid_adbs'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install droid_adbs

## Usage

Example:

```
require 'droid_adbs'

::DroidAdbs.device_serial = "device cerial you would like to connect" # set device_serial as a class variable
::DroidAdbs.devices # means `adb devices`
::DroidAdbs.install(app_path) # install `app_path` to the device
```

Please read yard documents if you would like to know more.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Rubygems
- https://rubygems.org/gems/droid_adbs

## Documents
You can get document by `yard` command.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/KazuCocoa/droid_adbs. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
