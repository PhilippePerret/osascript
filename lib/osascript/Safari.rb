module Osascript
class Safari
class << self

  # Open URL +url+ in front document or a new window if
  # +options[new_window]+ is true
  # 
  def open_url(url, options = nil)
    options ||= {}
    where = 
      if options[:new_window]
        "(make new tab in window 1)"
      else
        "front document"
      end
    code = <<~CODE
    if count of window is 0
      make new document
    end 
    set the URL of #{where} to \"#{url}\"
    CODE
    Osascript::__asrun(code, 'Safari')
  end

  # Run a javascript code in the front document or the 
  # +options[:where]+ tab.
  # 
  def run_javascript(code, options = nil)
    options ||= {}
    where = options[:where] || 'front document'
    code = <<~CODE
    do Javascript "#{code}" in #{where}
    CODE
    Osascript::__asrun(code, 'Safari')
  end

  # @return the name of the front document
  def window_name(options = nil)
    options ||= {}
    where = options[:where] || 'front window'
    code = <<~CODE
    if count of window is 0
      return null
    else
      return name of (#{where})
    end
    CODE
    Osascript::__asrun(code, 'Safari')
  end

  # @return the URL of front document or of the options[:where]
  # tab (for instance : options[:where] = 'tab 2 of window 1').
  def get_url(options = nil)
    options ||= {}
    where = options[:where] || 'front document'
    code = <<~CODE
    if count of window is 0
      return null
    else
      return URL of (#{where})
    end
    CODE
    Osascript::__asrun(code, 'Safari')
  end

end #/<< self Safari
end #/class Safari
end #/module Osascript
