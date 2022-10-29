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
    wait(2)
    assert_equal 'https://www.amazon.com/', get_url_of_front_window, "Le site d'Amazon devrait être ouvert dans Safari"
    Osascript::Safari.run_javascript('window.location.href = \\"https://www.atelier-icare.net\\"')
    wait(2)
    assert_equal 'Atelier Icare', get_name_of_front_window, "Javascript code should have been run."
  end

  def test_window_name
    Osascript::Safari.open_url('https://www.atelier-icare.net')
    wait(2)
    assert_equal 'https://www.atelier-icare.net/', get_url_of_front_window, "Le site de l'atelier Icare devrait être ouvert dans Safari"
    actual_name = Osascript::Safari.window_name
    expected_name = 'Atelier Icare'
    assert_equal expected_name, actual_name, "Front window name should be #{expected_name.inspect}. It's #{actual_name.inspect}."
  end

  def test_document_url
    Osascript::Safari.open_url('https://www.amazon.com')
    wait(2)
    assert_equal 'https://www.amazon.com/', get_url_of_front_window, "Le site d'Amazon devrait être ouvert dans Safari"
    actual_url    = Osascript::Safari.get_url
    expected_url  = 'https://www.amazon.com/'
    assert_equal expected_url, actual_url, "Front document url should be #{expected_url.inspect}. It's #{actual_url.inspect}."
  end
end #/class OsascriptSafariTest
