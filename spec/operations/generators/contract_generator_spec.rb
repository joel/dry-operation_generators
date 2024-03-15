# frozen_string_literal: true

module Operations
  module Generators
    RSpec.describe ContractGenerator, type: :generator do
      setup_default_destination

      tests described_class

      let(:contract_path) { "app/operations/users/create/contract.rb" }

      let(:contract) { content_for("app/operations/users/create/contract.rb") }

      subject(:contract_generator) do
        run_generator(
          %w[
            user
            create
          ]
        )
      end

      it "copy templates" do
        contract_generator

        expect(File).to exist("#{destination_root}/#{contract_path}")
      end

      it "uses the expected template files" do
        contract_generator

        expect(content_for(contract_path)).to match(/class Contract/)
      end

      context "with component option" do
        let(:contract_path) { "components/identity/users/operations/users/create/contract.rb" }

        subject(:contract_generator) do
          run_generator(
            %w[
              user
              create
              --component identity/users
            ]
          )
        end

        it "copy templates" do
          contract_generator

          expect(File).to exist("#{destination_root}/#{contract_path}")
        end
      end

      context "with references" do
        let(:contract) { content_for("app/operations/addresses/create/contract.rb") }

        subject(:contract_generator) do
          run_generator(
            [
              "address",
              "create",
              "name:string{required}",
              "alias:string{optional}",
              "user:references{required}"
            ]
          )
        end

        it "generates contract.rb with correct content" do
          contract_generator

          expect(contract).to eql(
            <<~CONTENT
              # frozen_string_literal: true

              module Addresses
                module Create
                  class Contract < Dry::Validation::Contract

                    params(Base::Schema, Schema)

                    # Add domain validation rules here

                    rule(:user_id) do
                      key.failure("must exist") if User.where(id: value).none?
                    end

                  end
                end
              end
            CONTENT
          )
        end
      end
    end
  end
end
