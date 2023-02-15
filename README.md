# Osascript

Welcome to this *MacOs-Only* new gem!

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

---

<a name="keystroke"></a>

### Keystroke

The `Osascript::Key` class and its `press` method let you simulate key strokes.

**Syntax**

~~~ruby
require 'osascript'

Osascript::Key.press(
    <key or array of key>[, <application>|nil][, <options>]
)
~~~


You can "press" a simple key:

~~~ruby
require 'osascript'

Osascript::Key.press("a")
~~~

… in a particular application:

~~~ruby
require 'osascript'

Osascript::Key.press("a", "TextEdit")
~~~

… or a word:

~~~ruby
Osascript::Key.press("Hello world !")
~~~

… or a list of keys:

~~~ruby
Osascript::Key.press(["a","b","c"])
~~~

You can set a delay between each stroke:

~~~ruby
Osascript::Key.press(["a","b","c"], nil, {delay: 2.5})
# 2.5 seconds between each stroke
~~~

… or a list of words:

~~~ruby
Osascript::Key.press(["Hello", 'world'])
~~~

You can press a key with a modifier:

~~~ruby
Osascript::Key.press({"a", modifiers:[:command]})
# => select all
Osascript::Key.press({"c", modifiers:[:option]})
# => stroke a "Ç"
~~~

… or a list of keys with modifiers:

~~~ruby
Osascript::Key.press([
    {key:"z", modifiers:[:command]},
    {key:"z", modifiers:[:command, :shift]},
    {key:"z", modifiers:[:command]},
])
~~~

… or a key with (supplementary) delay before:

~~~ruby
Osascript::Key.press([
    {key:"z", delay: 4}, # wait 4 seconds before press "z"
])
~~~

You can press a key as a `Symbol`:

~~~ruby
Osascript::Key.press(:space)
~~~

… or a list of keys as `Symbol`:

~~~ruby
Osascript::Key.press(["a", :space, :enter, :left_arrow])
~~~

… or any of these above:

~~~ruby
Osascript::Key.press([
    "a",
    "hello",
    :left_arrow
    {key: "v", modifiers:[:command]},
    {key: :BACKSPACE, modifiers:[:command]}
])
~~~

#### Available Symbol Keys

~~~ruby
# min or maj

:down_arrow     # or :DOWN_ARROW
:up_arrow       # idem
:left_arrow
:right_arrow
:enter
:return
:backspace
:escape
:space
:caps_lock
:tab

~~~

> Tip: to simulate the "Delete" button in a dialog box, use `{key: :backspace, modifiers:[:command]}`

#### Available modifiers

~~~ruby
# Only min

:command
:option
:control
:shift

~~~

> They are AppleScript modifiers.

---

<a name="terminal"></a>

### With Terminal

~~~ruby
require 'osascript'

def run_in_terminal(keys, **options)
  Osascript::Key.press(keys, 'Terminal', **options)
end

#
# Open a new window in Terminal console
# 
run_in_terminal({key: "n", modifiers:[:command]})
# 
# Run a script (to see all files in current folder, even hidden ones)
# 
run_in_terminal("ls -la")

~~~

---

<a name="preview"></a>

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

<a name="safari"></a>

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

