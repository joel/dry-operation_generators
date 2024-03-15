# frozen_string_literal: true

module Operations
  module Generators
    class RepositoryGenerator < Rails::Generators::NamedBase
      include Base::Generators::BaseGenerator

      source_root File.expand_path("repository/templates", __dir__)

      def generate_files
        super

        template "repository.rb.erb", "#{root_file_path}/operations/#{plural_name}/#{verb}/repository.rb"
      end
    end
  end
end
