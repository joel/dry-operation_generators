# frozen_string_literal: true

require "zeitwerk"
loader = Zeitwerk::Loader.for_gem
loader.ignore("#{__dir__}/dry-operations.rb")
loader.setup

require "rails/generators"

require "operations/generators/setup_generator"

require "operations/base"

module Operations
end
