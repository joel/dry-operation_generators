# frozen_string_literal: true

module Operations
  module Generators
    class SetupGenerator < ::Rails::Generators::Base
      hook_for :test_framework, as: "operations:setup" # Should call test_unit:operations:setup but doesn't ¯\_(ツ)_/¯

      def copy_initializer_file
        initializer "operation_generators.rb", File.read(File.expand_path("setup/templates/generators.rb.tt", __dir__))
      end
    end
  end
end
