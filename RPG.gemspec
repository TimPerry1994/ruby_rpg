# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name         = "RPG"
  spec.version      = "1.0"
  spec.authors      = ["Timothy Perry"]
  spec.email        = ["timperry@fsmail.net"]
  spec.summary      = %q{A simple text based RPG}
  spec.desctiption  = %q{An RPG in which you are placed in a room, in which the user must choose where to go and try to escape the dungeon while gathering as much gold as possible.}
  spec.homepage     = "http://domainforproject.com/"
  spec.license      = "MIT"

  spec.files        = ['lib/RPG.rb']
  spec.executables  = ['bin/RPG']
  spec.test_files   = ['tests/test_RPG.rb']
  sped.require_paths = ["lib"]
end
