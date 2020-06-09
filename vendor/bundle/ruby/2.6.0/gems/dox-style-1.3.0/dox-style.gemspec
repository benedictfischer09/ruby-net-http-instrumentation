# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "dox/style/version"

Gem::Specification.new do |spec|
  spec.name          = "dox-style"
  spec.version       = Dox::Style::VERSION
  spec.authors       = ["James Klein"]
  spec.email         = ["kleinjm007@gmail.com"]

  spec.summary       = "Shared Doximity Rubocop styles"
  spec.homepage      = "https://github.com/doximity/dox-style"

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(bin|test|spec|features|vendor|tasks|tmp)/})
  end
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 1.16"
  spec.add_development_dependency "generator_spec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake", ">= 10.0"
  spec.add_development_dependency "rspec", ">= 3.0"
  spec.add_development_dependency "rspec_junit_formatter"
  spec.add_development_dependency "sdoc"

  spec.add_runtime_dependency "rubocop", "~> 0.77"
  spec.add_runtime_dependency "rubocop-performance", "~> 1.5.1"
  spec.add_runtime_dependency "rubocop-rails", "~> 2.2.0"
  spec.add_runtime_dependency "rubocop-rspec", "~> 1.37.0"
end
