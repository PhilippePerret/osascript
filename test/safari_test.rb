require 'test_helper'
class OsascriptSafariTest < Minitest::Test

  def setup
    super
  end

  def teardown
    quit_safari
  end

  # --- Test Utils Methods ---

  def quit_safari
    # `osascript -e 'tell app "Safari" to quit'`
  end

  def get_name_of_front_window
    `osascript -e 'tell application "Safari" to return name of front window'`.to_s.strip       
  end

  def get_url_of_front_window
    `osascript -e 'tell application "Safari" to return URL of front document'`.to_s.strip       
  end

  # --- Tests ---

  def test_open_url_in_safari
    url       = "https://www.atelier-icare.net"
    wnd_name  = 'Atelier Icare'
    Osascript::Safari.open_url(url)
    sleep 1
    assert_equal wnd_name, get_name_of_front_window, "Safari front window name should be #{wnd_name.inspect}. It is #{get_name_of_front_window.inspect}"
  end

  def test_run_javascript_in_safari
    Osascript::Safari.open_url('https://www.amazon.com')
    wait(4)
    assert_equal 'https://www.amazon.com/', get_url_of_front_window, "Le site d'Amazon devrait être ouvert dans Safari"
    Osascript::Safari.run_javascript('window.location.href = \\"https://www.atelier-icare.net\\"')
    wait(2)
    assert_equal 'Atelier Icare', get_name_of_front_window, "Javascript code should have been run."
  end

end #/class OsascriptSafariTest
