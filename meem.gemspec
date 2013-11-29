# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'meem/version'

Gem::Specification.new do |spec|
  spec.name          = "meem"
  spec.version       = Meem::VERSION
  spec.authors       = ["Johannes Gorset"]
  spec.email         = ["jgorset@gmail.com"]
  spec.description   = "Meme generator"
  spec.summary       = "Meem is a command-line tool to create memes"
  spec.homepage      = "https://github.com/jgorset/meem"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "meme_captain"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
