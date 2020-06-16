# -*- encoding: utf-8 -*-
# stub: dox-style 1.3.0 ruby lib

Gem::Specification.new do |s|
  s.name = "dox-style".freeze
  s.version = "1.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["James Klein".freeze]
  s.date = "2020-02-21"
  s.email = ["kleinjm007@gmail.com".freeze]
  s.homepage = "https://github.com/doximity/dox-style".freeze
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Shared Doximity Rubocop styles".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, [">= 1.16"])
      s.add_development_dependency(%q<generator_spec>.freeze, [">= 0"])
      s.add_development_dependency(%q<pry>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 10.0"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 3.0"])
      s.add_development_dependency(%q<rspec_junit_formatter>.freeze, [">= 0"])
      s.add_development_dependency(%q<sdoc>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<rubocop>.freeze, ["~> 0.77"])
      s.add_runtime_dependency(%q<rubocop-performance>.freeze, ["~> 1.5.1"])
      s.add_runtime_dependency(%q<rubocop-rails>.freeze, ["~> 2.2.0"])
      s.add_runtime_dependency(%q<rubocop-rspec>.freeze, ["~> 1.37.0"])
    else
      s.add_dependency(%q<bundler>.freeze, [">= 1.16"])
      s.add_dependency(%q<generator_spec>.freeze, [">= 0"])
      s.add_dependency(%q<pry>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, [">= 10.0"])
      s.add_dependency(%q<rspec>.freeze, [">= 3.0"])
      s.add_dependency(%q<rspec_junit_formatter>.freeze, [">= 0"])
      s.add_dependency(%q<sdoc>.freeze, [">= 0"])
      s.add_dependency(%q<rubocop>.freeze, ["~> 0.77"])
      s.add_dependency(%q<rubocop-performance>.freeze, ["~> 1.5.1"])
      s.add_dependency(%q<rubocop-rails>.freeze, ["~> 2.2.0"])
      s.add_dependency(%q<rubocop-rspec>.freeze, ["~> 1.37.0"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, [">= 1.16"])
    s.add_dependency(%q<generator_spec>.freeze, [">= 0"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 10.0"])
    s.add_dependency(%q<rspec>.freeze, [">= 3.0"])
    s.add_dependency(%q<rspec_junit_formatter>.freeze, [">= 0"])
    s.add_dependency(%q<sdoc>.freeze, [">= 0"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 0.77"])
    s.add_dependency(%q<rubocop-performance>.freeze, ["~> 1.5.1"])
    s.add_dependency(%q<rubocop-rails>.freeze, ["~> 2.2.0"])
    s.add_dependency(%q<rubocop-rspec>.freeze, ["~> 1.37.0"])
  end
end
