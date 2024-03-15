# frozen_string_literal: true

module Operations
  module Generators
    RSpec.describe ActionGenerator, type: :generator do
      setup_default_destination

      tests described_class

      let(:action) { content_for("app/operations/users/create/action.rb") }

      subject(:action_generator) do
        run_generator(
          [
            "user",
            "create",
            "firstname:string{optional}",
            "lastname:string{optional}",
            "email:string{required}",
            "user:references{required}"
          ]
        )
      end

      it "copy template" do
        action_generator

        expect(File).to exist("#{destination_root}/app/operations/users/create/action.rb")
      end

      it "generates action.rb with correct content" do
        action_generator

        expect(action).to eql(
          <<~RUBY
            # frozen_string_literal: true

            require "dry/transaction/operation"

            module Users
              module Create
                class Action

                  include Dry::Transaction::Operation

                  def call(params)
                    instance, input = params.values_at(:instance, :input)

                    attributes = input.dup.except(
                      :id, :created_at, :updated_at, :user_id
                    ) # use except or slice to filter out unwanted attributes

                    # Recommended to use slice to filter out unwanted attributes
                    # attributes = input.dup.slice(
                    #   TODO: whitelisted attributes here
                    # )

                    instance.assign_attributes(attributes)

                    instance.user = User.find_by(id: input[:user_id])

                    # Here comes the Busniness Logic


                    if instance.save
                      Success(instance)
                    else
                      Failure(instance)
                    end
                  end

                end
              end
            end
          RUBY
        )
      end

      context "with component option" do
        let(:action_path) { "components/identity/users/operations/users/create/action.rb" }

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
