# frozen_string_literal: true

module Operations
  module Generators
    RSpec.describe ScaffoldGenerator, type: :generator do
      setup_default_destination

      tests described_class

      let(:args) do
        [
          "user",
          "create",
          "firstname:string{optional}",
          "lastname:string{optional}",
          "email:string{required}"
        ]
      end

      let(:config) do
        { destination_root: File.expand_path("../../tmp", __dir__) }
      end

      let(:generators) do
        [
          ActionGenerator,
          ContractGenerator,
          SchemaGenerator,
          ValidationGenerator,
          RepositoryGenerator,
          RegisterGenerator,
          OperationGenerator
        ]
      end

      let(:libraries) do
        [
          "Dry::Validation",
          "Dry::Transaction",
          "Dry::Schema",
          "Dry::Container"
        ]
      end

      before do
        generators.each do |generator|
          allow(generator).to receive(:start)
        end
        libraries.each do |library|
          stub_const(library, true)
        end
      end

      it "calls the generators" do
        run_generator(args)

        expect(generators).to all(have_received(:start).with(args, config))
      end
    end
  end
end
