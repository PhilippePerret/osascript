=begin
  Pour activer des touches dans une application quelconque avec :
  Osascript::Key.press(:down_arrow, 'Terminal')

  @Examples
  ---------

  Osascript::Key.press([
      "Hello", 
      {key:"a", modifiers:[:command]},
      "Bonjour",
      {key:" tout le monde ", delay: 3},
      {key:"a", modifiers:[:command]},
      {key:"c", modifiers:[:command]},
      :RIGHT_ARROW,
      {key:"v", modifiers:[:command]},
      {key:"s", modifiers:[:command]},
      "my document",
      :RETURN
    ], 
    "TextEdit", 
    {delay: 1}
    )

  Should: write "Hello" in a TextEdit document, then select "Hello"
  and replace it with "Bonjour", then write " tout le monde ", then
  select all, then copy all in the clipboard, then move to the end,
  then paste the phrase, then save document as "my document.txt".

  @usage

    Osacript::Key.press([<keys>][,"<application>"][,{<options>}])

    keys {Array|String|Integer|Hash|Symbol}

      When {Integer} : a key code — exemple 125 for arrow down
      When {String}  : the key to press, for example "v"
      When {Symbol}  : a value among : :down_arrow, :up_arrow, :left_arrow,
                right_arrow, :enter, :return, :erase, :backspace,
                :space, :escape, :caps_lock, :tab
      When {Hash} : a key with modifiers
        {
          key: the key (integer, string, symbol),
          modifiers: {Array} with values among :shift, :control,
                      :command, :option
          delay: {Integer} wait before this seconds time
        }
        For examples: 
          {key:"v", modifiers:[:option]}
          [key:123, modifiers:[:shift, :control]]

      When {Array} : list of keys defined as above


    with options

      delay:    Time between strokes (default: 0.5)

    'option', 'shift', 'command', 'control'



See also: 
https://eastmanreference.com/complete-list-of-applescript-key-codes

=end
module Osascript
class Key
class << self
  def press(keys, app = nil, options = nil)
    options ||= {}
    options.key?(:delay) || options.merge!(delay: 0.5)
    if app.nil?
      press_without_app(keys, options)
    else
      press_with_app(keys, app, options)
    end
  end
  def press_with_app(keys, app, options)
    code = <<~CODE
    activate
    activate
    #{code_system_events(keys, options)}
    CODE
    # puts "code :\n#{code}"
    Osascript::__asrun(code, app)
  end

  def press_without_app(keys, options)
    code = <<~CODE
    #{code_system_events(key, options)}
    CODE
    Osascript::__asrun(code)
  end

  def code_system_events(keys, options)
    keys = [keys] unless keys.is_a?(Array)
    keys_stroke = keys.map do |key|
      "delay #{options[:delay]}\n#{key_to_sysevents_code(key)}"
    end.join("\n")
    <<~CODE
      tell application "System Events"
        #{keys_stroke}
      end tell
    CODE
  end

  def key_to_sysevents_code(key)
    if key.is_a?(Hash)
      modifiers = key[:modifiers]
      key = key[:key]
      delay_sup = key[:delay] # délai ajouté
    else
      modifiers = nil
      delay_sup = nil
    end
    code = case key
      when String
        "keystroke \"#{key}\""
      when Integer
        "key code #{key}"
      when Symbol
        "key code #{KEY2CODE[key]}"
      else 
        raise "Unvalid class pour key: #{key.class}"
      end
    if modifiers
      modifiers = modifiers.map {|mod| "#{mod} down" }.join(', ')
      code = "#{code} using {#{modifiers}}"
    end
    if delay_sup
      code = "delay #{delay_sup}\n#{code}"
    end
    return code
  end
end #/<< self Key

KEY2CODE = {
  down_arrow: 125, DOWN_ARROW: 125,
  up_arrow: 126, UP_ARROW: 126,
  left_arrow: 123, LEFT_ARROW: 123,
  right_arrow: 124, RIGHT_ARROW: 124,
  enter: 76, ENTER: 76,
  return: 36, RETURN: 36,
  backspace: 51, BACKSPACE: 51,
  escape: 53, ESCAPE: 53,
  space: 49, SPACE: 49,
  caps_lock: 57, CAPS_LOCK: 57,
  tab: 48, TAB: 48

}
end #/class Key
end #/module Osascript
