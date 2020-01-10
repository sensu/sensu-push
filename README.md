# Sensu Run

Sensu Run is a utility for executing Sensu Go checks on systems that cannot run the Sensu Go Agent. Sensu Run wraps the check command execution, constructs a Sensu Go Event, and posts the Event to a Sensu Go Backend API for processing. This utility is written in Ruby (1.8+) and only uses stdlib in hopes it can run on the vast majority of systems. This utility was inspired by https://hackage.haskell.org/package/sensu-run.

## Installation

```
gem install sensu-run
```

## Usage

```
$ sensu-run -h
Usage: sensu-run [options]
    -h, --help                       Display this message
    -V, --version                    Display version
    -n, --namespace NAME             Sensu Go namespace
    -c, --check-name NAME            Sensu Go check name
    -e, --entity-name NAME           Sensu Go entity name
    -t, --check-timeout SECONDS      Sensu Go check execution timeout
    -T, --check-ttl SECONDS          Sensu Go check TTL
    -H, --handlers NAME[,NAME]       Sensu Go event handlers
    -b, --backends URL[,URL]         URL or comma-delimited list of Sensu Go Backend API URLs
    -k, --api-key KEY                Sensu Go Backend API key
```

Example:

```
$ sensu-run -c true -e laptop -b http://localhost:8080 -k '46691493-dee5-46d8-8d2b-f37a18424afc' -- true
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sensu/sensu-run.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
