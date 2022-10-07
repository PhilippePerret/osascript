require "test_helper"

class OsascriptTest < Minitest::Test

  def setup
    super
  end

  def teardown
    `osascript -e 'tell app "Preview" to quit'`    
  end

  def test_that_it_has_a_version_number
    refute_nil ::Osascript::VERSION
  end

  def test_osascript_respond_to___asrun
    assert_respond_to Osascript, :__asrun
  end

  # On peut invoquer la méthode principale
  # Osascript::__asrun pour exécuter un code
  # et recevoir le résultat.
  # Cette version ne fait pas appel au second argument (le
  # nom de l'application)
  def test___asrun_run_code_without_app
    # skip
    res = Osascript.__asrun(<<~CODE.strip)
    tell application "Finder"
      set names to name of every window
    end tell
    set text item delimiters to {"', '"}
    set names to names as text
    set text item delimiters to {}
    return "['" & names & "']"
    CODE

    refute_nil res
    res = eval(res)
    assert_instance_of Array, res
  end

  # On peut invoquer la méthode principale
  # Osascript::__asrun pour exécuter un code
  # et recevoir le résultat.
  # Cette version fait appel au second argument (le
  # nom de l'application)
  def test___asrun_run_code_with_app
    # skip
    res = Osascript.__asrun(<<~CODE.strip, 'Finder')
    set names to name of every window
    tell me
      set text item delimiters to {"', '"}
      set names to names as text
      set text item delimiters to {}
      return "['" & names & "']"
    end tell
    CODE

    refute_nil res
    res = eval(res)
    assert_instance_of Array, res
  end

end
