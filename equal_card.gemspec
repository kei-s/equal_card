# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'equal_card/version'

Gem::Specification.new do |spec|
  spec.name          = "equal_card"
  spec.version       = EqualCard::VERSION
  spec.authors       = ["kei-s"]
  spec.email         = ["kei.shiratsuchi@gmail.com"]
  spec.summary       = %q{EqualCard solver.}
  spec.description   = %q{Calculate EqualCard answers.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "thor", "~> 0.19"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.1"
end
