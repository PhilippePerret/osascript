# Osascript

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/osascript`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'osascript'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install osascript

## Usage


### With any application

~~~ruby
require 'osascript'

Osascript.on?("applicationName")
# => true if application <applicationName> is running

# p.e.

Osascript.on?('Preview')

~~~

~~~ruby
require 'osascript'

Osascript.quit("applicationName")
# => quit application applicationName

# p.e.
Osascript.quit("Final Cut Pro")

~~~

### With Preview

~~~ruby
require 'osascript'

Osascript::Preview.open_document("/path/to/doc.pdf")
# => open document in Preview

Osascript::Preview.document_opened?("/path/to/doc.pdf")
# => return true if document is opened in Preview

Osascript::Preview.documents_paths
# => return {Array} of path {String} of every document
#    opened in Preview

Osascript::Preview.documents_names
# => return {Array} of name {String} of every document
#    opened in Preview
~~~


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/osascript.

