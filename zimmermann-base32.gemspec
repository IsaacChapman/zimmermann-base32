$LOAD_PATH << File.expand_path("../lib", __FILE__)
require 'zbase32/version'

Gem::Specification.new do |s|
  s.name = "zimmermann-base32"
  s.summary = "Zimmermann's Base32"
  s.description = "Implements ZBase32; an easy to remember and unambiguous Base32 charset."
  s.version = ZBase32::VERSION
  s.homepage = "https://www.github.com/jamesdphillips/zimmermann-base32"
  s.license = "MIT"
  s.email = ["jamesdphillips@gmail.com"]

  # Orginally authored by pso
  s.authors = ["pso", "James Phillips"]

  # Only tested on 2.2+
  s.required_ruby_version = Gem::Requirement.new(">= 2.2.0")

  # Files
  s.files         = `git ls-files -z`.split("\x0")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

  # Deps
  s.add_development_dependency "bundler", "~> 1.7"
  s.add_development_dependency "coveralls", "~> 0.7"
  s.add_development_dependency "rake", "~> 10.3"
  s.add_development_dependency "minitest", "~> 5"
  s.add_development_dependency "rantly", "~> 1"
end
