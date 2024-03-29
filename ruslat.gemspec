lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ruslat/version"

Gem::Specification.new do |spec|
  spec.name = "ruslat"
  spec.version = Ruslat::VERSION
  spec.authors = ["Vasiliy Sukhachev"]
  spec.email = ["vsuhachev@yandex.ru"]

  spec.summary = %(Bidirectional russian transliteration library)
  spec.homepage = "https://github.com/vsuhachev/ruslat"
  spec.license = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    fail "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files = `git ls-files -z`.split("\x0")
    .reject { |f| f.match(%r{^(test|spec|features|bin)/}) }
    .reject { |f| f.match(/^(\..+|(Gem|Rake)file|.+\.gemspec)$/) }
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2"
  spec.add_development_dependency "rake", "~> 13"
  spec.add_development_dependency "rspec", "~> 3"
  spec.add_development_dependency "standard", "~> 1"
end
