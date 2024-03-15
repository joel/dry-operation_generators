# frozen_string_literal: true

module Operations
  module Generators
    RSpec.describe RepositoryGenerator, type: :generator do
      setup_default_destination

      tests described_class

      let(:repository) { content_for("app/operations/users/create/repository.rb") }

      subject(:repository_generator) do
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
        repository_generator

        expect(File).to exist("#{destination_root}/app/operations/users/create/repository.rb")
      end

      it "generates repository.rb with correct content" do
        repository_generator

        expect(repository).to eql(
          <<~RUBY
            # frozen_string_literal: true

            require "dry/transaction/operation"
            require "dry/monads"

            module Users
              module Create
                class Repository

                  include Dry::Transaction::Operation

                  def call(input)
                    instance = User.new

                    if instance
                      Success({instance:, input:})
                    else
                      Failure({input:})
                    end
                  end

                end
              end
            end
          RUBY
        )
      end

      context "with component option" do
        let(:repository_path) { "components/identity/users/operations/users/create/repository.rb" }

        subject(:repository_generator) do
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
          repository_generator

          expect(File).to exist("#{destination_root}/#{repository_path}")
        end
      end
    end
  end
end
