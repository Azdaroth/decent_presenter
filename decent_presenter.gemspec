# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'decent_presenter/version'

Gem::Specification.new do |spec|
  spec.name          = "decent_presenter"
  spec.version       = DecentPresenter::VERSION
  spec.authors       = ["Karol Galanciak"]
  spec.email         = ["karol.galanciak@gmail.com"]
  spec.summary       = %q{Simple and easy to use presentation layer for your Rails models.}
  spec.description   = %q{Simple and easy to use presentation layer for your Rails models.}
  spec.homepage      = "https://github.com/Azdaroth/decent_presenter"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "coveralls"
  spec.add_dependency "activesupport", ">= 3.2"
end
