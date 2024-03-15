# frozen_string_literal: true

module Operations
  module Generators
    RSpec.describe ValidationGenerator, type: :generator do
      setup_default_destination

      tests described_class

      let(:validation) { content_for("app/operations/users/create/validation.rb") }

      subject(:validation_generator) do
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
        validation_generator

        expect(File).to exist("#{destination_root}/app/operations/users/create/validation.rb")
      end

      it "generates validation.rb with correct content" do
        validation_generator

        expect(validation).to eql(
          <<~RUBY
            # frozen_string_literal: true

            require "dry/transaction/operation"
            require "dry/validation"
            require "dry/validation/contract"

            module Users
              module Create
                class Validation

                  include Dry::Transaction::Operation

                  def call(input)
                    params = Contract.new.call(input)

                    return Failure(params.errors) if params.failure?

                    Success(input)
                  end

                end
              end
            end
          RUBY
        )
      end

      context "with component option" do
        let(:validation_path) { "components/identity/users/operations/users/create/validation.rb" }

        subject(:validation_generator) do
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
          validation_generator

          expect(File).to exist("#{destination_root}/#{validation_path}")
        end
      end
    end
  end
end
