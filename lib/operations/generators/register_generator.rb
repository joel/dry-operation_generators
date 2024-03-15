# frozen_string_literal: true

module Operations
  module Generators
    class RegisterGenerator < Rails::Generators::NamedBase
      include Base::Generators::BaseGenerator

      source_root File.expand_path("register/templates", __dir__)

      def generate_files
        super

        template "register.rb.erb", "#{root_file_path}/operations/#{plural_name}/#{verb}/register.rb"
      end
    end
  end
end
