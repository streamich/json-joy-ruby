require_relative "lib/jsonjoy/version"

Gem::Specification.new do |spec|
  spec.name = "jsonjoy"
  spec.version = Jsonjoy::VERSION
  spec.authors = ["streamich"]
  spec.email = ["streamich@gmail.com"]

  spec.summary = "json-joy port to Ruby"
  spec.homepage = "https://github.com/streamich/json-joy-ruby"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/streamich/json-joy-ruby/issues",
    "changelog_uri" => "https://github.com/streamich/json-joy-ruby/releases",
    "source_code_uri" => "https://github.com/streamich/json-joy-ruby",
    "homepage_uri" => spec.homepage
  }

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir.glob(%w[LICENSE.txt README.md {exe,lib}/**/*]).reject { |f| File.directory?(f) }
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
