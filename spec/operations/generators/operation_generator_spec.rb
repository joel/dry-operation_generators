# frozen_string_literal: true

module Operations
  module Generators
    RSpec.describe OperationGenerator, type: :generator do
      setup_default_destination

      tests described_class

      let(:operation) { content_for("app/operations/users/create/operation.rb") }

      subject(:operation_generator) do
        run_generator(
          [
            "user",
            "create",
            "firstname:string{optional}",
            "lastname:string{optional}",
            "email:string{required}"
          ]
        )
      end

      it "copy template" do
        operation_generator

        expect(File).to exist("#{destination_root}/app/operations/users/create/operation.rb")
      end

      it "generates operation.rb with correct content" do
        operation_generator

        expect(operation).to eql(
          <<~RUBY
            # frozen_string_literal: true

            require "dry/transaction/operation"

            module Users
              module Create
                class Operation

                  include Dry::Transaction(container: Register)

                  step :validate_inputs,   with: "users.create.validation"
                  step :initialize_record, with: "users.create.repository"

                  step :create_record,     with: "users.create.action"

                end
              end
            end
          RUBY
        )
      end

      context "with component option" do
        let(:operation_path) { "components/identity/users/operations/users/create/operation.rb" }

        subject(:operation_generator) do
          run_generator(
            %w[
              user
              create
              firstname:string{optional}
              lastname:string{optional}
              --component identity/users
            ]
          )
        end

        it "copy templates" do
          operation_generator

          expect(File).to exist("#{destination_root}/#{operation_path}")
        end
      end
    end
  end
end
