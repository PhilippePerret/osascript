=begin
  Work with any application.
=end
module Osascript

  # Return the front window (or other window defined in options)
  # properties.
  # @return Window properties or nil if application is not launched
  #   * :name [String] Window name
  #   * :bounds [Array] Window bounds
  #   * :index [Integer] Window index
  #   * :id [Integer] Window ID
  #   * :zoomable [Boolean] True if window is zoomable
  #   * :zoomed   [Boolean] True if window is zoomed
  #   * :visible  [Boolean] etc.
  #   * :miniaturizable [Boolean]
  #   * :miniaturized [Boolean]
  #   * closeable [Boolean]
  #   * :closed [Boolean]
  #   * :titled [Boolean]
  #   * :floating [Boolean]
  #   * :modal [Boolean]
  # @param [String] app_name Name of the application
  # @param [Hash]   options
  # @option options [String|Integer] :window Other window to consider
  # 
  def self.get_window_properties(app_name, options = nil)
    if on?(app_name)
      window  = (options && options[:window]) || 'front window'
      code    = "return (properties of #{window})"
      ret = __asrun(code, app_name)
      # On se retrouve avec un texte du type :
      # "document:Mon doc, floating:false, bounds:4, 12, 23, 45 etc."
      # 
      ret = ret.split(/(?:, )?([a-z]+)\:/)
      ret.shift # vide
      table = {}
      while ret.count > 0
        prop  = ret.shift.to_sym
        value = ret.shift
        value = case prop
        when :bounds
          eval("[#{value}]")
        else
          begin
            eval(value)
          rescue NameError
            value
          end
        end
        table.merge!(prop => value)
      end
      return table
    end
  end

  # Set any properties of front window of +app_name+ app (or other
  # window defined in options) to +properties+
  # @param [String] app_name Name of the application
  # @param [Hash] properties  Properties of the window to set (depends
  #                           on application)
  # @option properties [Rectangle]  :bounds  Position and size of window
  # @option properties [String]     :name    The window name
  # @option properties [Integer]    :index   Index of window
  # @option properties [Boolean]    :zoomed  true if window must be zoomed
  # @option properties [Boolean]    :miniaturized  true if window must be miniaturized
  # @option properties [Boolean]    :visible  false if window must be hidden
  # @param [Hash] options  Table with {:window}
  def self.set_window(app_name, properties, options = nil)
    if on?(app_name)
      window  = (options && options[:window]) || 'front window'
      table = properties.map do |k, v|
        "{\"#{k}\", #{v.inspect}}"
      end.join(', ')
      code = <<~CODE
      set table to {#{table}}
      tell #{window}
        repeat with dprop in table
          set propName to item 1 of dprop
          set propValue to item 2 of dprop
          if propName is "bounds" then
            set bounds of it to propValue
          else if propName is "name" then
            set name of it to propValue
          else if propName is "index" then
            set index of it to propValue
          else if propName is "zoomed" then
            set zoomed of it to propValue
          else if propName is "miniaturized" then
            set miniaturized of it to provalue
          else if propName is "visible" then
            set visible of it to propValue
          end if
        end repeat
      end tell
      CODE
      __asrun(code, app_name)
    end
  end

  # Set bounds of front window of +app_name+ app (or other
  # window defined in options) to +bounds+
  # @param app_name [String] Name of the application
  # @param bounds [Array] [top-left, bottom-left, top-right, bottom-right]
  # @param options [Hash] Table with {:window}
  def self.set_window_bounds(app_name, bounds, options = nil)
    if on?(app_name)
      window  = (options && options[:window]) || 'front window'
      code = <<~CODE
      set bounds of #{window} to {#{bounds.join(', ')}}
      CODE
      __asrun(code, app_name)
    end
  end

  # Set dimension of front window of app +app_name+ (or other window
  # defined with options) to +dim+
  # @param app_name [String] Name of the application
  # @param dim [Hash] Table with {:width, :height}
  # @param options [Hash] Table with {:window}
  def self.set_window_dimension(app_name, dim, options = nil)
    if on?(app_name)
      window  = (options && options[:window]) || 'front window'
      code = <<~CODE
      tell #{window}
        set theBounds to bounds of it
        set topRight to (item 1 of theBounds) + #{dim[:width]}
        set bottomRight to (item 2 of theBounds) + #{dim[:height]}
        set bounds of it to {item 1 of theBounds, item 2 of theBounds, topRight, bottomRight}
      end
      CODE
      __asrun(code, app_name)
    end
  end

  # Set position of front window of +app_name+ application (or other
  # window defined with options) to +pos+
  # @param app_name [String] Name of the application
  # @param pos [Hash] Table with {:top, :left}
  # @param options [Hash] Table with {:window}
  def self.set_window_position(app_name, pos, options = nil)
    if on?(app_name)
      window  = (options && options[:window]) || 'front window'
      code = <<~CODE
      tell #{window}
        set theBounds to bounds of it
        set width to (item 3 of theBounds) - (item 1 of theBounds)
        set topRight to #{pos[:left]} + width
        set height to (item 4 of theBounds) - (item 2 of theBounds)
        set bottomRight to #{pos[:top]} + height
        set bounds of it to {#{pos[:left]}, #{pos[:top]}, topRight, bottomRight}
      end
      CODE
      __asrun(code, app_name)
    end
  end


end
