# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cachify/version'

Gem::Specification.new do |spec|
  spec.name          = "cachify"
  spec.version       = Cachify::VERSION
  spec.authors       = ["Kashyap"]
  spec.email         = ["kashyap.kmbc@gmail.com"]
  spec.description   = %q{TODO: Write a gem description}
  spec.summary       = %q{TODO: Write a gem summary}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake", ">= 0.9"
  spec.add_development_dependency "rspec", ">= 2.13"
  spec.add_development_dependency "webmock", "1.13.0"

  spec.required_ruby_version = ">= 1.9.2"
end
