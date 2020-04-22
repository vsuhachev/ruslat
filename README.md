# Ruslat

Ruslat is library for bidirectional transliteration for russian to latin.

It is Ruby implementation of Andrey V. Lukyanov transliteration system.
See [http://tapemark.narod.ru/ruslat.html](http://tapemark.narod.ru/ruslat.html)
for more info.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruslat'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruslat

## Usage

```ruby
require 'ruslat'

Ruslat.rus_to_lat('Привет Мир!') # => "Privet Mir!" 
Ruslat.lat_to_rus('Privet Mir!') # => "Привет Мир!"

Ruslat.rus_to_lat('АЛЁША') # => "ALYoShA"
Ruslat.case_correct('ALYoShA') # => "ALYOSHA"

typo = 'CAPA'
typo.bytes # => [67, 65, 80, 65] 
Ruslat.rus_typo_correct(typo) # => "САРА"
Ruslat.rus_typo_correct(typo).bytes # => [208, 161, 208, 144, 208, 160, 208, 144]

typo = 'Sаrа'
typo.bytes # => [83, 208, 176, 114, 208, 176] 
Ruslat.lat_typo_correct(typo) # => "Sara"
Ruslat.lat_typo_correct(typo).bytes # => [83, 97, 114, 97]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
[https://github.com/vsuhachev/ruslat](https://github.com/vsuhachev/ruslat). This
project is intended to be a safe, welcoming space for collaboration, and
contributors are expected to adhere to the 
[Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).
