require_relative 'lib/osascript/version'

Gem::Specification.new do |s|
  s.name          = "osascript"
  s.version       = Osascript::VERSION
  s.authors       = ["PhilippePerret"]
  s.email         = ["philippe.perret@yahoo.fr"]

  s.summary       = %q{Interaction per AppleScript with world}
  s.description   = %q{Gem macOS-only permettant de communiquer avec les autres applications par AppleScript}
  s.homepage      = "https://github.com/PhilippePerret/osascript"
  s.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  s.metadata["allowed_push_host"] = "https://github.com/PhilippePerret/osascript"
  # s.metadata["allowed_push_host"] = "https://rubygems.org"

  s.add_development_dependency 'minitest'
  s.add_development_dependency 'minitest-reporters'

  s.metadata["homepage_uri"] = s.homepage
  s.metadata["source_code_uri"] = "https://github.com/PhilippePerret/osascript"
  s.metadata["changelog_uri"] = "https://github.com/PhilippePerret/osascript/CHANGE.log"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  s.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|features)/}) }
  end
  s.bindir        = "exe"
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]
end
