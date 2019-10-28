
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "net/http/instrumentation/version"

Gem::Specification.new do |spec|
  spec.name          = "nethttp-instrumentation-dox-fork"
  spec.version       = Net::Http::Instrumentation::VERSION
  spec.authors       = ["Ashwin Chandrasekar", "Ben Fischer"]
  spec.email         = ["ops@doximity.com"]

  spec.summary       = %q{OpenTracing Instrumentation for Net::HTTP requests.}
  spec.homepage      = "http://github.com/doximity/ruby-net-http-instrumentation"
  spec.license       = "Apache-2.0"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "opentracing", "~> 0.3"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "opentracing_test_tracer", "~> 0.1"
  spec.add_development_dependency "webmock", "~> 3.4.2"

end
