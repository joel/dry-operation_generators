# frozen_string_literal: true

module Operations
  module Generators
    class ActionGenerator < Rails::Generators::NamedBase
      include Base::Generators::BaseGenerator

      source_root File.expand_path("action/templates", __dir__)

      def generate_files
        super

        template "action.rb.erb", "#{root_file_path}/operations/#{plural_name}/#{verb}/action.rb"
      end
    end
  end
end
