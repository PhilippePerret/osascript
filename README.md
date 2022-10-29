# Osascript

Welcome to this new *MacOs-Only* gem!

In this directory, you'll find the files you need to be able to 
package up your Ruby library into a gem. Put your Ruby code in 
the file `lib/osascript`. To experiment with that code, run `bin/console` for an interactive prompt.

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

Only with MacOs.

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

### With Safari

~~~ruby
Osascript::Safari.open_url("https://my.url/to/open.html")
# => open the ur in the front document

Osascript::Safari.open_url("https://my.url/to/open.html", {new_window: true})
# => open the url in a new tab of front window

Osascript::Safari.get_url
# => return the url of the front document

Osascript::Safari.get_url(where: 'tab 3 of window 2')
# => return the url of the tab 3 of window 2

Osascript::Safari.window_name
# => return the displayed name of the front window

Osascript::Safari.window_name(where: 'window 3')
# => return the displayed name of the window 3

Osascript::Safari.run_javascript("alert('Hello word!')")
# => run the javascript code in the front document

Osascript::Safari.run_javascript("alert('Hello word!')", {where:'tab 2 of window 1'})
# => run the javascript code in the tab 2 of window 1

~~~


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/PhilippePerret/osascript.

