# frozen_string_literal: true

module Operations
  module Generators
    class ValidationGenerator < Rails::Generators::NamedBase
      include Base::Generators::BaseGenerator

      source_root File.expand_path("validation/templates", __dir__)

      def generate_files
        super

        template "validation.rb.erb", "#{root_file_path}/operations/#{plural_name}/#{verb}/validation.rb"
      end
    end
  end
end
