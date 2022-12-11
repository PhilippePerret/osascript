require 'test_helper'

class OsascriptAnyAppTest < Minitest::Test

  def setup
    super
  end

  def teardown
    quit_preview
  end

  def quit_preview
    `osascript -e 'tell app "Preview" to quit'`    
  end

  # Open test file in Preview application
  def open_test_file
    filepath = File.join(Osascript::TEST_FOLDER,'resources','documents','mon.pdf')
    open_in_preview(filepath)    
  end

  # Ouvrir le fichier +fpath+ dans Preview
  # Sans passer par le gem…
  def open_in_preview(fpaths)
    fpaths = [fpaths] unless fpaths.is_a?(Array)
    fpaths.each do |fpath|
      `osascript -e 'tell application "Preview"' -e 'open POSIX file "#{fpath}"' -e 'end tell'`    
    end
  end

  # @return property +prop+ of the Preview window
  def get_window_properties(window = 'front window')
    res = `osascript -e 'tell application "Preview" to return properties of #{window}`
    return res    
  end


  def test_get_window_properties
    open_test_file
    props = Osascript.get_window_properties('Preview')
    assert_instance_of Hash, props
    assert_equal "mon.pdf", props[:name]
    assert props[:resizable]
    assert props[:zoomable]
    assert props[:closeable]
    refute props[:zoomed]
  end

  def test_get_window_properties_with_not_launched_app
    quit_preview
    res = Osascript.get_window_properties('Preview')
    refute res, "Method should return NIL value…"
  end

  def test_set_window_method
    assert_respond_to Osascript, :set_window
    open_test_file
    ini_props = Osascript.get_window_properties('Preview')
    new_name = "Nouveau nom de fichier"
    Osascript.set_window('Preview', {name: new_name})
    props = Osascript.get_window_properties('Preview')
    assert_equal(new_name, props[:name], "Window name should have changed to #{new_name.inspect}. It is #{props[:name].inspect} #{" (same as init)" if ini_props[:name] == props[:name]}")
  end

  def test_set_bounds
    assert_respond_to Osascript, :set_window_bounds
    open_test_file
    ini_props = Osascript.get_window_properties('Preview')
    new_bounds = [100,100,1000,800]
    Osascript.set_window_bounds('Preview', new_bounds)
    fin_props = Osascript.get_window_properties('Preview')
    refute_equal new_bounds, ini_props[:bounds], "Window bounds should not be the same as init."
    assert_equal new_bounds, fin_props[:bounds], "Window should have been resized…"
  end

  def test_set_window_dimension
    assert_respond_to Osascript, :set_window_dimension
    open_test_file
    ini_props = Osascript.get_window_properties('Preview')
    puts "Bounds initial : #{ini_props[:bounds].inspect}"
    new_dims = {width: 4000, height: 100}
    Osascript.set_window_dimension('Preview', new_dims)
    new_props = Osascript.get_window_properties('Preview')
    expected = [] + ini_props[:bounds]
    expected[2] = expected[0] + new_dims[:width]
    expected[3] = expected[1] + new_dims[:height]
    assert_equal expected, new_props[:bounds], "Window dimensions should have changed (expected: #{expected.inspect}, actual: #{new_props[:bounds].inspect}."
  end

end #/ class OsascriptAnyAppTest
