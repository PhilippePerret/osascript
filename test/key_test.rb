require 'test_helper'

class OsascriptKeyTest < Minitest::Test

  def setup
    super
  end
  def teardown
    super
  end

  def test_make_document_with_text
    Osascript::Key.press([
        "Hello", 
        {key:"a", modifiers:[:command]},
        "Bonjour",
        " tout le monde ",
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
  end

end 
