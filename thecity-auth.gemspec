$:.push File.expand_path("../lib", __FILE__)
require "the_city_auth/version"

Gem::Specification.new do |s|
  s.name        = "thecity-auth"
  s.version     = TheCityAuth::Version::STRING
  s.platform    = Gem::Platform::RUBY
  s.summary     = "Simple header builder for The City API"
  s.email       = "kcburge@gmail.com"
  s.homepage    = "http://github.com/kcburge/thecity-auth"
  s.description = "Simple header builder for The City API"
  s.authors     = ['Kevin Burge']

  s.rubyforge_project = "thecity-auth"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency("bundler")
  s.add_development_dependency("rspec")
end
