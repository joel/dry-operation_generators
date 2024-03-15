# frozen_string_literal: true

module Operations
  module Generators
    class OperationGenerator < Rails::Generators::NamedBase
      include Base::Generators::BaseGenerator

      desc "Generates operation for operation"

      hook_for :test_framework, as: "operations:operation"

      source_root File.expand_path("operation/templates", __dir__)

      def generate_files
        super

        template "operation.rb.erb", "#{root_file_path}/operations/#{plural_name}/#{verb}/operation.rb"
      end
    end
  end
end
