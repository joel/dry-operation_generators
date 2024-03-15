# frozen_string_literal: true

module Operations
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.expand_path("install/templates", __dir__)

      desc "This generator installs the operations setup."

      def copy_setup_files
        copy_file "application_contract.rb.tt", "app/operations/application_contract.rb"
        copy_file "application_schema.rb.tt", "app/operations/application_schema.rb"
        copy_file "dry_schema.rb.tt", "config/initializers/dry_schema.rb"
        copy_file "dry_types.rb.tt", "config/initializers/dry_types.rb"
      end
    end
  end
end
