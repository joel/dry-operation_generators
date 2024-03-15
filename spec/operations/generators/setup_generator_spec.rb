# frozen_string_literal: true

module Operations
  module Generators
    RSpec.describe SetupGenerator, type: :generator do
      setup_default_destination

      tests described_class

      let(:initializer) { content_for("config/initializers/operation_generators.rb") }

      it "copy initializer" do
        run_generator

        expect(File).to exist("#{destination_root}/config/initializers/operation_generators.rb")
      end

      it "is the expected file" do
        run_generator

        expect(initializer).to match(%r{require "operations/generators/install_generator"})
        expect(initializer).to match(/if defined\?\(Dry::Transaction\)/)
      end
    end
  end
end
