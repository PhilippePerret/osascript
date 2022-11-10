require 'test_helper'

class OsascriptKeyTest < Minitest::Test

  def setup
    super
  end
  def teardown
    super
  end

  def test_make_document_with_text
    #
    # Ce test permet de tester un peu tout :
    # - un texte tapé 
    # - une touche avec un modifier
    # - une touche définie par un Symbol
    # - une touche "symbolique" et un modifier
    # - le délai entre chaque touche.
    # 
    start_time = Time.now.to_i
    `echo "Dans le presse-papier" | pbcopy`
    Osascript::Key.press([
        "Hello",
        {key:"a", modifiers:[:command]},
        "Bonjour",
        " tout le monde ",
        {key:"a", modifiers:[:command]},
        {key:"c", modifiers:[:command]},
        :RIGHT_ARROW,
        {key:"v", modifiers:[:command]},
        {key:"a", modifiers:[:command]},
        {key:"c", modifiers:[:command]},
        {key:"q", modifiers:[:command]},
        {key: :BACKSPACE, modifiers:[:command]}
      ], 
      "TextEdit", 
      {delay: 0.5}
      )
    delay_time = Time.now.to_i - start_time
    puts "delay_time = #{delay_time.inspect}"
    pp = `pbpaste`
    puts "pp : #{pp.inspect}"
    assert_equal "Bonjour tout le monde Bonjour tout le monde ", pp
    assert delay_time > 5, "La procédure aurait du prendre au moins 5 secondes… Le 'delay' ne semble pas être pris en compte."
  end



end 
