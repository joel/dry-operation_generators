# frozen_string_literal: true

module Operations
  module Generators
    RSpec.describe RegisterGenerator, type: :generator do
      setup_default_destination

      tests described_class

      let(:register) { content_for("app/operations/users/create/register.rb") }

      subject(:register_generator) do
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
        register_generator

        expect(File).to exist("#{destination_root}/app/operations/users/create/register.rb")
      end

      it "generates register.rb with correct content" do
        register_generator

        expect(register).to eql(
          <<~RUBY
            # frozen_string_literal: true

            module Users
              module Create
                class Register

                  extend Dry::Container::Mixin

                  namespace "users.create" do
                    register "validation" do
                      Validation.new
                    end

                    register "repository" do
                      Repository.new
                    end

                    register "action" do
                      Action.new
                    end
                  end

                end
              end
            end
          RUBY
        )
      end

      context "with component option" do
        let(:register_path) { "components/identity/users/operations/users/create/register.rb" }

        subject(:register_generator) do
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
          register_generator

          expect(File).to exist("#{destination_root}/#{register_path}")
        end
      end
    end
  end
end
