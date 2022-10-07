module Osascript

  ##
  # = main =
  # 
  # Méthode principale qui exécute le code +code+
  # 
  def self.__asrun(code, application = nil)
    if application
      code = <<~TEXT
      tell application "#{application}"
        #{code}
      end tell
      TEXT
    end
    resultat = `osascript <<'TEXT'
      #{code.strip}
    TEXT
    `
    return resultat.strip
  end

end #/module Osascript
