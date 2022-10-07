=begin

  Module spécial pour l'application Preview/Aperçu

=end
module Osascript
class Preview
class << self

  # Ouvre le document +filepath+
  def open_document(filepath)
    Osascript::__asrun("open POSIX file \"#{filepath}\"", 'Preview')
  end

  # @return true si le document de path +filepath+ est ouvert
  def document_opened?(filepath)
    code = <<~CODE
    repeat 10 times
      try
        set doc to first document whose path is "#{filepath}"
        return true
      on error errMsg
        delay 0.5
      end try
    end repeat
    return false
    CODE
    retour = Osascript::__asrun(code, 'Preview')
    return retour == 'true'
  end

  # @return {Array} La liste de tous les documents ouverts dans 
  # preview
  def documents_names
    liste = Osascript::__asrun(<<~CODE)
      tell application "Preview"
        set names to name of every document
      end tell
      set text item delimiters to {"', '"}
      set names to names as text
      set text item delimiters to {}
      return "['" & names & "']"
    CODE
    # puts "liste = #{liste.inspect}"
    return liste == "['']" ? [] : eval(liste)
  end

  def documents_paths
    liste = Osascript::__asrun(<<~CODE)
      tell application "Preview"
        set paths to path of every document
      end tell
      set text item delimiters to {"', '"}
      set paths to paths as text
      set text item delimiters to {}
      return "['" & paths & "']"
    CODE
    # puts "liste = #{liste.inspect}"
    return liste == "['']" ? [] : eval(liste)
  end

end #/<< self
end #/class Preview
end #/module Osascript
