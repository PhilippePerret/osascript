$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "osascript"

require "minitest/autorun"
require 'minitest/reporters'

reporter_options = { 
  color: true,          # pour utiliser les couleurs
  slow_threshold: true, # pour signaler les tests trop longs
}
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]
