require "test_helper"

class OsascriptPreviewTest < Minitest::Test

  def setup
    super
  end

  def teardown
    quit_preview
  end

  def quit_preview
    `osascript -e 'tell app "Preview" to quit'`    
  end

  # Ouvrir le fichier +fpath+ dans Preview
  # Sans passer par le gem…
  def open_in_preview(fpaths)
    fpaths = [fpaths] unless fpaths.is_a?(Array)
    fpaths.each do |fpath|
      `osascript -e 'tell application "Preview"' -e 'open POSIX file "#{fpath}"' -e 'end tell'`    
    end
  end

  # @return la liste des chemins d'accès ouverts dans Preview
  # Sans passer par le gem…
  def get_opened_docs
    res = `osascript -e 'tell application "Preview" to return path of every document'`
    res.strip.split(',').map{|fpath|fpath.strip}
  end


  def test_open_in_preview
    # skip
    filepath = File.join(Osascript::TEST_FOLDER,'resources','documents','mon.pdf')
    filepath2 = File.join(Osascript::TEST_FOLDER,'resources','documents','autre.pdf')
    Osascript::Preview.open_document(filepath)
    Osascript::Preview.open_document(filepath2)
    assert_includes get_opened_docs, filepath
    assert_includes get_opened_docs, filepath2
  end

  # Test qui vérifie que le test de la présence d'un
  # certain document dans aperçu est détectée correctement
  def test_it_respond_true_if_a_apercu_doc_is_open
    # skip
    # 
    # On ferme Aperçu (pour être sûr que le document n'est pas
    # ouvert)
    #
    quit_preview

    # 
    # Ouvrir le document dans Overview
    # 
    filepath = File.join(Osascript::TEST_FOLDER,'resources','documents','mon.pdf')
    open_in_preview(filepath)


    # 
    # Le document est bien ouvert dans Preview
    #
    assert Osascript::Preview.document_opened?(filepath)

    #
    # Le test avec le nom doit être faux
    refute Osascript::Preview.document_opened?(File.basename(filepath))
    
    # 
    # On ferme Aperçu
    #
    `osascript -e 'tell app "Preview" to quit'`

  end



  def test_preview_documents_names
    quit_preview
    assert_empty Osascript::Preview.documents_paths
    filepath  = File.join(Osascript::TEST_FOLDER,'resources','documents','mon.pdf')
    filepath2 = File.join(Osascript::TEST_FOLDER,'resources','documents','autre.pdf')
    open_in_preview([filepath,filepath2])
    # --- Test ---
    docs = Osascript::Preview.documents_paths
    assert_instance_of Array, docs
    refute_empty docs
    assert_includes docs, filepath
    assert_includes docs, filepath2
  end

  def test_preview_documents_paths
    quit_preview
    assert_empty Osascript::Preview.documents_names
    filepath = File.join(Osascript::TEST_FOLDER,'resources','documents','mon.pdf')
    filepath2 = File.join(Osascript::TEST_FOLDER,'resources','documents','autre.pdf')
    open_in_preview([filepath,filepath2])
    # --- Test ---
    docs = Osascript::Preview.documents_names
    assert_instance_of Array, docs
    refute_empty docs
    refute_includes docs, filepath
    assert_includes docs, File.basename(filepath)
    refute_includes docs, filepath2
    assert_includes docs, File.basename(filepath2)
  end

end
