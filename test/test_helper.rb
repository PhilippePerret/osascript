$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "osascript"

require "minitest/autorun"
require 'minitest/reporters'

class String
  def bleu; "\033[0;96m#{self}\033[0m"  end
  def gris; "\033[0;90m#{self}\033[0m"  end
  def rouge; "\033[0;91m#{self}\033[0m" end
  def vert; "\033[0;92m#{self}\033[0m"  end
end #/class String

reporter_options = { 
  color: true,          # pour utiliser les couleurs
  slow_threshold: true, # pour signaler les tests trop longs
}
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]


def wait(secondes, msg = "J'attends un peu…")
  STDOUT.write "#{msg}".bleu
  sleep secondes
  STDOUT.write "\r#{' '*(msg.length + 20)}\r"
end
