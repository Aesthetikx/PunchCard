$LOAD_PATH << File.expand_path('../lib', __FILE__)
require 'punch_card/version'

Gem::Specification.new do |s|
  s.name        = 'punch_card'
  s.version     = PunchCard::VERSION
  s.license     = 'MIT'
  s.summary     = %q{Command line time tracker app and sinatra frontend}
  s.description = %q{punch_card provides an easy to use command line interface
                      for 'punching in' and 'punching out' of your projects.
                      A Sinatra web front end provides information to help with
                      time reporting, i.e. hours worked on a montly basis.}
  s.authors     = ['John DeSilva']
  s.email       = ['desilvjo@umich.edu']
  s.homepage    = 'https://github.com/Aesthetikx/PunchCard'
  s.files       = `git ls-files`.split("\n")
end
