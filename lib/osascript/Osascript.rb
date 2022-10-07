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


  # @return true if application +app_name+ is running
  def self.on?(app_name)
    retour = __asrun("tell application \"System Events\" to return (name of processes) contains \"#{app_name}\"")
    # puts "retour = #{retour.inspect}"
    return retour == "true"
  end

  # Quit application +app_name+ if it's running
  def self.quit(app_name)
    if on?(app_name)
      __asrun("tell application \"#{app_name}\" to quit")
    end
  end

end #/module Osascript
