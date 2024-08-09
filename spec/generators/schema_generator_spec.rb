# frozen_string_literal: true

require "generators/schema/schema_generator"

module Operations
  module Generators
    RSpec.describe SchemaGenerator, type: :generator do
      setup_default_destination

      tests described_class

      let(:schema) { content_for("app/operations/users/create/schema.rb") }
      let(:base_schema) { content_for("app/operations/users/base/schema.rb") }

      subject(:action_generator) do
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

      it "copy templates" do
        action_generator

        expect(File).to exist("#{destination_root}/app/operations/users/base/schema.rb")
        expect(File).to exist("#{destination_root}/app/operations/users/create/schema.rb")
      end

      it "generates schema.rb with correct option" do
        run_generator(
          [
            "user",
            "create",
            "firstname:string{optional}"
          ]
        )

        expect(schema).to match(/optional\(:firstname\)\.filled\(:string\)/)
      end

      it "generates schema.rb with correct content" do
        action_generator

        expect(schema).to eql(
          <<~RUBY
            # frozen_string_literal: true

            # Sanitizes, coerces and type-checks input data

            module Users
              module Create
                Schema = Dry::Schema.Params do
                  optional(:firstname).filled(:string)
                  optional(:lastname).filled(:string)
                  required(:email).filled(:string)
                end
              end
            end
          RUBY
        )
      end

      it "generates base/schema.rb with correct content" do
        action_generator

        expect(base_schema).to eql(
          <<~RUBY
            # frozen_string_literal: true

            # Sanitizes, coerces and type-checks input data

            module Users
              module Base
                Schema = Dry::Schema.Params do

                  # Add Common Fields Here
                end
              end
            end
          RUBY
        )
      end

      context "with component option" do
        let(:action_path) { "components/identity/users/operations/users/create/schema.rb" }

        subject(:action_generator) do
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
          action_generator

          expect(File).to exist("#{destination_root}/#{action_path}")
        end
      end
    end
  end
end
