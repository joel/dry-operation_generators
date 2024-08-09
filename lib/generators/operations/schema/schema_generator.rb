# frozen_string_literal: true

require "rails/generators"
require "operations/base"

module Operations
  module Generators
    class SchemaGenerator < Rails::Generators::NamedBase
      include Base::Generators::BaseGenerator

      desc "Generates schema for operation"

      hook_for :test_framework, as: "operations:schema"

      source_root File.expand_path("templates", __dir__)

      def generate_files
        super

        template "base/schema.rb.erb", "#{root_file_path}/operations/#{plural_name}/base/schema.rb"
        template "schema.rb.erb", "#{root_file_path}/operations/#{plural_name}/#{verb}/schema.rb"
      end
    end
  end
end
