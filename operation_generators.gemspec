# frozen_string_literal: true

require_relative "lib/operations/version"

Gem::Specification.new do |spec|
  spec.name = "dry-operation_generators"
  spec.version = Operations::VERSION
  spec.authors = ["Joel Azemar"]
  spec.email = ["joel.azemar@gmail.com"]

  spec.summary = "Generates Dry RB operation files"
  spec.homepage = "https://github.com/joel/generators"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.3.0"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github .circleci appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails"
  spec.add_dependency "zeitwerk"
  # spec.add_dependency "operation_generators-base"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata["rubygems_mfa_required"] = "true"
end
