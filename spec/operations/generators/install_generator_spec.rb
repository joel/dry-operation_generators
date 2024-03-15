# frozen_string_literal: true

module Operations
  module Generators
    RSpec.describe InstallGenerator, type: :generator do
      setup_default_destination

      tests described_class

      let(:initializer_schema)        { "config/initializers/dry_schema.rb" }
      let(:initializer_types)         { "config/initializers/dry_types.rb" }
      let(:application_contract_path) { "app/operations/application_contract.rb" }
      let(:application_schema_path)   { "app/operations/application_schema.rb" }

      it "copy setup files" do
        run_generator

        expect(File).to exist("#{destination_root}/#{application_contract_path}")
        expect(File).to exist("#{destination_root}/#{application_schema_path}")
        expect(File).to exist("#{destination_root}/config/initializers/dry_schema.rb")
      end

      it "is the expected initializer_schema file" do
        run_generator

        expect(content_for(initializer_schema)).to match(/Dry::Schema\.Params\.class\.include\(ExtractKeysFromSchema\)/)
      end

      it "is the expected initializer_types file" do
        run_generator

        expect(content_for(initializer_types)).to match(/include Dry\.Types\(\)/)
      end

      it "is the expected application_contract.rb" do
        run_generator

        expect(content_for(application_contract_path)).to match(/class ApplicationContract/)
      end

      it "is the expected application_schema.rb" do
        run_generator

        expect(content_for(application_schema_path)).to match(/class ApplicationSchema/)
      end
    end
  end
end
