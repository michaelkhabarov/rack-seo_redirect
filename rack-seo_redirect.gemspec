# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack/seo_redirect/version'

Gem::Specification.new do |spec|
  spec.name          = "rack-seo_redirect"
  spec.version       = Rack::SeoRedirect::VERSION
  spec.authors       = ["Michael Khabarov"]
  spec.email         = ["michaelkhabarov@alphastate.ru"]
  spec.description   = %q{Remove or add www and trailing slash from urls for Rack applications. Use it if you don't want (or can't) edit Nginx or Apache configs.}
  spec.summary       = %q{Make www and trailing slash redirects from Rack}
  spec.homepage      = "https://github.com/michaelkhabarov/rack-seo_redirect"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "rspec", "~> 2.0"

  spec.add_dependency "rack"
end
