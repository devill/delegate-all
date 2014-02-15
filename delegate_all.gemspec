lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |s|
  s.name        = 'delegate-all'
  s.version     = '1.0.0'
  s.date        = '2014-02-15'
  s.summary     = "Automatically delegate method calls to another object"
  s.description = "Defines a few functions on the class that will delegate calls"
  s.authors     = ["Rafael Ordog aka DeVill"]
  s.email       = 'rafael@ordog.tk'
  s.files       = Dir.glob("{lib}/**/*")
  s.homepage    = 'http://github.com/devill/delegate_all'
  s.license     = 'GPL2'

  s.add_development_dependency('rspec')
end