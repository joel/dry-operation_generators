# frozen_string_literal: true

module DryOperationGenerators
  RSpec.describe Main do
    subject(:foo) { described_class.new }
    describe "#dry_operation_generators" do
      context "when all is good" do
        let(:input) { "foo" }
        let(:result) { "foo" }

        it do
          expect(foo.dry_operation_generators(input)).to eql(result)
        end
      end
    end
  end
end
