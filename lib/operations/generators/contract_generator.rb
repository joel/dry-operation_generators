# frozen_string_literal: true

module Operations
  module Generators
    class ContractGenerator < Rails::Generators::NamedBase
      include Base::Generators::BaseGenerator

      desc "Generates contract for operation"

      hook_for :test_framework, as: "operations:contract"

      source_root File.expand_path("contract/templates", __dir__)

      def generate_files
        super

        template "base/contract.rb.erb", "#{root_file_path}/operations/#{plural_name}/base/contract.rb"
        template "contract.rb.erb", "#{root_file_path}/operations/#{plural_name}/#{verb}/contract.rb"
      end
    end
  end
end
